enum ResponseKind 
{
	none,
	speak,
	sentence,
	scene,
	response,
	print,
	script
}

class ParserBase extends Validateable {

    constructor() {
        base.constructor();
    }

    /** Parses the Concept to create ResponseRules based on Cues and Sequences. */
    function _processConcept() {
        foreach (index, item in _cues) {
            if (item instanceof WCScript.Sequence) {
                _parseSequence(item, index);
            } else {
                _createResponseRule(_name, _getRuleName(index), item, index)
            }
        }
    }

    function _parseSequence(sequence, index) {
        local ruleIndex = 0;
        local cues = clone sequence._cues;
        local criterias = sequence._criterias;
        local ruleName = _getRuleName(index);
        
        // Reverse the cue list as ::pop() will be used
        cues.reverse();

        while (cues.len() > 0) {

            local cue = cues.pop();
            if (cue instanceof WCScript.Cue) {
                // The first cue of the sequence adopts the concept name.
                // The rest of the rules get a unique concept name to follow up from the previous cue.
                local ruleConcept = ruleIndex == 0 ? _name : ruleName + ruleIndex.tostring();

                // Add the next followup if any (excludes last cue).
                if (cues.len() > 0) {
                    local delay = 0;

                    while(cues instanceof WCScript.Delay) {
                        delay = cues.pop()._delay;
                    }

                    cue._followups.append(
                        WCScript.Followup()
                            .concept(ruleName + (ruleIndex + 1).tostring())
                            .target(cues.top()._actor)
                            .delay(delay)
                    );
                }

                // Append the Sequence's Criterias to ResponseRules when empty.
                if (cue._criterias.len() == 0 && criterias.len() > 0) {
                    cue.criterias(criterias);
                }

                // Create the ResponseRule.
                _createResponseRule(ruleConcept, ruleName + ruleIndex.tostring(), cue, index);
                ruleIndex++;
            }
        }
    }

    function _getFollowups(followups) {
        return followups.map(function (value) {
            if (type (value) == "string") {
                value = WCScript.Followup().concept(value);
            }

            return {
                target = value._target,
                concept = value._concept,
                delay = value._delay
            };
        });
    }

    /**
        Generate a unique name for every Cue and Sequence
        from the concept name. (concept_A, concept_B, concept_C...)
    */
    function _getRuleName(index) {
        return _name + "_" + WCScript.getSuffix(index);
    }

    function _createResponseRule(ruleConcept, ruleName, cue, index) {
        local criterias = clone cue._criterias;
        local onlyTriggerOnce = false;
        local recordConcept = false;

        // Check if Cue is triggered by original concept name.
        if (ruleConcept == _name) {
            onlyTriggerOnce = _triggerOnce;
            recordConcept = _record;

            // Check if Cue is remarkable.
            if (_remarkable != null) {
                criterias.append(["concept", "TLK_REMARK"]);
                criterias.append(["subject", ruleConcept]);
                criterias.append(["distance",
                    _remarkable.len() == 1 ? 0 : _remarkable[0],
                    _remarkable.len() == 1  ? _remarkable[0] : _remarkable[1]
                ]);
                criterias.append(["speaking", 0]);
            } else {
                criterias.append(["concept", ruleConcept]);
            }
            
            // Check if Cue should only be triggered once.
            if (onlyTriggerOnce) {
                local conceptSaid = "worldSaid" + ruleConcept;
                criterias.append([@(query) !(conceptSaid in query) || query[conceptSaid] != 1]);
            }
        } else {
            criterias.append(["concept", ruleConcept])
        }

        local ruleMatch = "worldMatch" + ruleName;
        criterias.append([@(query) !(ruleMatch in query) || query[ruleMatch] != 1])
        
        if (!WCScript.isSurvivor(cue._actor)) {
            criterias.append(["name", cue._actor]);
        } else {
            criterias.append(["who", cue._actor]);
            criterias.append(["is" + cue._actor + "alive", 1])
        }

        local responseRuleParams = WCScript.ResponseRuleParams(
            cue._repeatableResponses,
            cue._promptResponsesSequentially,
            cue._promptResponsesOnce,
            cue._matchOnce
        );

        local responseRule = WCScript.ResponseRule(
            ruleName,
            criterias.map(WCScript.convertToCriterion),
            [],
            responseRuleParams
        );

        // Iterate the list of Responses.
        foreach (index, value in cue._responses) {
            local applyContext = {};
            if (onlyTriggerOnce || recordConcept) {
                applyContext.said <- { context = "Said" + ruleConcept, value = 1, duration = -1 };
            }

            responseRule.responses.append(_createSingleResponse(index, value, cue, applyContext, responseRule));
        }

        // print("Created rule with name " + rule.name + ", concept " + ruleConcept + "\n");

        if (!rr_AddDecisionRule(responseRule)) {
            throw "Failed to add rule to decision database: " + rule.name;
        }
    }

    function _createSingleResponse(index, value, cue, applyContext, responseRule) {
        local callback = null;
        local applycontext = {};
        local scene = null;
        local responseThen = null;
        local scenePath = WCScript.isSurvivor(cue._actor) ? cue._actor + "/" : "npcs/";

        // Check if the Response is just a string.
        if (type (value) == "string" || value == null) {
            scene = value != null ? "scenes/" + scenePath + value + ".vcd" : null;
        } else if (value instanceof WCScript.Response) {
            scene = value._scene != null ? "scenes/" + scenePath + value._scene + ".vcd" : null;

            if (value._callback != null) {
                callback = value._callback;
            }

            if (value._followups.len() > 0) {
                responseThen = WCScript.ResponseThen(_getFollowups(value._followups));
            }
        }

        if (callback == null && cue._callback != null) {
            callback = cue._callback;
        }

        // Check if the follow up is empty and the Cue has a defined follow up
        if (responseThen == null && cue._followups.len() > 0) {
            responseThen = WCScript.ResponseThen(_getFollowups(cue._followups));
        }

        local func = responseRule.PlayedResponse(index);
        if (callback != null) {
            local Func = func;
            func = function (speaker, query) {
                Func(speaker, query);
                callback(speaker, query);
            }
        }

        local callbackFunc = func;
        func = @(speaker, query) g_rr.rr_ApplyContext(speaker, query, applyContext, true, callbackFunc);

        // if ( "soundname" in value)
        // {
        //     local Func = func
        //     func = @( speaker, query ) g_rr.rr_EmitSound(speaker, query, soundname, applyContext, true, Func);
        // }

        // if ( "soundfile" in value )
        // {
        //     local volume = 1
        //     if ( "volume" in value )
        //         volume = volume
            
        //     local Func = func
        //     func = @( speaker, query ) g_rr.rr_PlaySoundFile(speaker, query, soundfile, applyContext, true, volume, Func);
        // }

        local kind = ResponseKind.none
        if (scene) {
            kind = ResponseKind.scene
        } else if (func) {	
            kind = ResponseKind.script
        }

        return WCScript.ResponseSingle(kind, scene, responseRule, func, responseThen);
    }
}

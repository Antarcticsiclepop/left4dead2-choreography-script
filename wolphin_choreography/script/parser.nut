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
                _createResponseRule(_value, _getRuleName(index), item, index)
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
                // The first cue of the sequence belongs to the concept.
                // The rest of the rules get a unique concept to follow up from the previous cue.
                local ruleConcept = ruleIndex == 0 ? _value : ruleName + ruleIndex.tostring();

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
        from the concept. (concept_A, concept_B, concept_C...)
    */
    function _getRuleName(index) {
        return _value + "_" + WCScript.getSuffix(index);
    }

    function _createResponseRule(ruleConcept, ruleName, cue, index) {
        local criterias = clone cue._criterias;
        local onlyTriggerOnce = false;
        local recordConcept = false;

        // Check if Cue is triggered by original concept
        if (ruleConcept == _value) {
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
            
            // Check if Cue should only be triggered once
            if (onlyTriggerOnce) {
                criterias.append(WCScript.criteriaNotSaid(ruleConcept));
            }
        } else {
            criterias.append(["concept", ruleConcept])
        }

        local ruleMatch = "Match" + ruleName;
        criterias.append(WCScript.criteriaNotValue(ruleMatch, 1))
        
        if (!WCScript.isSurvivor(cue._actor)) {
            criterias.append(["name", cue._actor]);
        } else {
            criterias.append(["who", WCScript.getExpresserTarget(cue._actor)]);
            criterias.append(["is" + cue._actor + "alive", 1])
        }

        local responseRuleParams = WCScript.ResponseRuleParams(
            cue._repeatableResponses,
            cue._promptResponsesSequentially,
            cue._promptResponsesOnce,
            cue._matchOnce
        );

        local responseRule = WCScript.ResponseRule(ruleName, criterias.map(WCScript.convertToCriterion), [], responseRuleParams);

        // Iterate the list of Responses.
        foreach (index, response in cue._responses) {
            local callbackList = [];
            if (onlyTriggerOnce || recordConcept) {
                callbackList.append(@(speaker, query) WCScript.setWorldContext("Said" + ruleConcept));
            }

            responseRule.responses.append(_createSingleResponse(index, response, cue, callbackList, responseRule));
        }

        // print("Created rule with name " + rule.name + ", concept " + ruleConcept + "\n");

        if (!rr_AddDecisionRule(responseRule)) {
            throw "Failed to add rule to decision database: " + rule.name;
        }
    }

    function _createSingleResponse(index, response, cue, callbackList, responseRule) {
        local scene = null;
        local responseThen = null;
        local scenePath = WCScript.isSurvivor(cue._actor) ? cue._actor + "/" : "npcs/";

        callbackList.append(responseRule.PlayedResponse(index));

        if (response instanceof WCScript.Response) {
            scene = response._scene != null ? "scenes/" + scenePath + response._scene + ".vcd" : null;
        } else {
            scene = response != null ? "scenes/" + scenePath + response + ".vcd" : null;
        }

        if (response instanceof WCScript.Response && response._callback != null) {
            callbackList.append(response._callback);
        } else if (cue._callback != null) {
            callbackList.append(cue._callback);
        }

        if (response instanceof WCScript.Response && response._followups.len() > 0) {
            responseThen = WCScript.ResponseThen(_getFollowups(response._followups));
        } else if (cue._followups.len() > 0) {
            responseThen = WCScript.ResponseThen(_getFollowups(cue._followups));
        }

        local kind = scene == null ? ResponseKind.script : ResponseKind.scene;
        return WCScript.ResponseSingle(kind, scene, responseRule, callbackList, responseThen);
    }
}

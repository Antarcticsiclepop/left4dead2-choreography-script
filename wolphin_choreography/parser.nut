/** Not a number. */
local NAN = sqrt(-1);

/** Fixes reference issues. */
local isValidSurvivor = isSurvivor;
local FollowupClass = Followup;
local parserPrint = printTable;
local ResponseThenClass = ResponseThen;
local ResponseRuleClass = ResponseRule;

class ParserBase extends CriteriaBase {

    constructor() {
        base.constructor();
    }

    /** Parses the Concept to create ResponseRules based on Cues and Sequences. */
    function _processConcept() {
        foreach (index, item in _cues) {
            if (item._className == "Sequence") {
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
            if (cue._className == "Cue") {
                // The first cue of the sequence adopts the concept name.
                // The rest of the rules get a unique concept name to follow up from the previous cue.
                local ruleConcept = ruleIndex == 0 ? _name : ruleName + ruleIndex.tostring();

                // Add the next followup if any (excludes last cue).
                if (cues.len() > 0) {
                    local delay = 0;

                    while(cues.top()._className == "Delay") {
                        delay = cues.pop()._delay;
                    }

                    cue._followups.append(
                        FollowupClass()
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
        return ResponseThenClass(followups.map(function (value) {
            if (type (value) == "string") {
                value = FollowupClass().concept(value);
            }

            return {
                target = value._target,
                concept = value._concept,
                delay = value._delay
            };
        }));
    }

    /**
        Generate a unique name for every Cue and Sequence
        from the concept name. (concept_A, concept_B, concept_C...)
    */
    function _getRuleName(index) {
        local suffix = "_" + (65 + index).tochar();
        return _name + suffix;
    }

    function _createResponseRule(ruleConcept, ruleName, cue, index) {
        local criteria = clone cue._criterias;
        local responses = [];
        local onlyTriggerOnce = false;
        local recordConcept = false;

        // Check if Cue is triggered by original concept name.
        if (ruleConcept == _name) {
            onlyTriggerOnce = _triggerOnce;
            recordConcept = _record;

            // Check if Cue is remarkable.
            if (_remarkable != null) {
                criteria.append(["concept", "TLK_REMARK"]);
                criteria.append(["subject", ruleConcept]);
                criteria.append(["distance",
                    _remarkable.len() == 1 ? 0 : _remarkable[0],
                    _remarkable.len() == 1  ? _remarkable[0] : _remarkable[1]
                ]);
                criteria.append(["speaking", 0]);
            } else {
                criteria.append(["concept", ruleConcept]);
            }
            
            // Check if Cue should only be triggered once.
            if (onlyTriggerOnce) {
                local remarkFlag = "worldSaid" + ruleConcept;
                criteria.append([@(query) !(remarkFlag in query) || remarkFlag in query && query[remarkFlag] != 1]);
            }

            criteria.extend(_criterias);
        } else {
            criteria.append(["concept", ruleConcept])
        }

        // Initial scene path
        local scenePath = "npcs/";

        // Check if target is not a playable survivor.
        if (!isValidSurvivor(cue._actor)) {
            criteria.append(["name", cue._actor]);
        } else {
            criteria.append(["who", cue._actor]);
            criteria.append(["is" + cue._actor + "alive", 1])
            // Change scene path to proper survivor.
            scenePath = cue._actor + "/";
        }

        // Iterate the list of Responses.
        foreach (value in cue._responses) {     
            local response = {
                applycontext = {},
                applycontexttoworld = true,
            };

            if (onlyTriggerOnce || recordConcept) {
                response.applycontext.said <- { context = "Said" + ruleConcept, value = 1, duration = NAN };
            }

            // Check if the Response is just a string.
            if (type (value) == "string" || value == null) {
                response.scenename <- value != null ? "scenes/" + scenePath + value + ".vcd" : null;
            } else {
                response.scenename <- value._scene != null ? "scenes/" + scenePath + value._scene + ".vcd" : null;
                if (value._followups.len() > 0) {
                    response.followup <- _getFollowups(value._followups);
                }
            }

            // Check if the follow up is empty and the Cue has a defined follow up
            if (!("followup" in response) && cue._followups.len() > 0) {
                response.followup <- _getFollowups(cue._followups);
            }

            responses.append(response);
        }

        local responseRule = ResponseRuleClass()
            .setRuleName(ruleName)
            .setGroupParams({
                permitrepeats = cue._repeatableResponses,
                sequential = cue._promptResponsesSequentially,
                norepeat = cue._promptResponsesOnce
            })
            .setCriteria(criteria)
            .setResponses(responses);

        // print("Created rule with name " + rule.name + ", concept " + ruleConcept + "\n");

        if (!rr_AddDecisionRule(responseRule)) {
            throw "Failed to add rule to decision database: " + rule.name;
        }
    }
}


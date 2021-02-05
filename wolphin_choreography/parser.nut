/** Not a number. */
local NAN = sqrt(-1);

/** Fixes reference issues. */
local isValidSurvivor = isSurvivor;
local FollowupClass = Followup;
local parserPrint = printTable;
local ResponseThenClass = ResponseThen;
local RuleClass = Rule;

class ParserBase extends CriteriaBase {

    /** Parses the Concept to create Rules based on Cues and Sequences. */
    function _processConcept() {
        local rules = [];

        foreach (index, item in _cues) {
            if (item._className == "Sequence") {
                rules.extend(_parseSequence(item, index));
            } else {
                rules.append(
                    _createResponseRule(_name, _getRuleName(index), item, index)
                );
            }
        }

        foreach (rule in rules) {
            local coderule = RuleClass();
                coderule.setRuleName(rule.name)
                coderule.setCriteria(rule.criteria.map(g_rr.rr_ProcessCriterion.bindenv(g_rr)))
                coderule.setResponses(rule.responses)
                coderule.setGroupParams(rule.group_params);

            foreach (r in coderule.responses) {
                r.rule = coderule;
            }

            if( !rr_AddDecisionRule(coderule) ) {
                throw "Failed to add rule to decision database: " + rule.name
            }
        }
    }

    function _parseSequence(sequence, index) {
        local rules = [];
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

                    cue.followup(
                        FollowupClass()
                            .concept(ruleName + (ruleIndex + 1).tostring())
                            .target(cues.top()._orator)
                            .delay(delay)
                    );
                }

                // Append the Sequence's Criterias to Rules when empty.
                if (cue._criterias.len() == 0 && criterias.len() > 0) {
                    cue.criterias(criterias);
                }

                // Create the Rule.
                local responseRule = _createResponseRule(ruleConcept, ruleName + ruleIndex.tostring(), cue, index);
                rules.append(responseRule);
                ruleIndex++;
            }
        }

        return rules;
    }

    function _getFollowup(followup) {
        if (type (followup) == "string") {
            followup = FollowupClass().concept(followup);
        }

        return ResponseThenClass(followup._target, followup._concept, followup._delay);
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
        local onlyTriggerOnce = false;
        local recordConcept = false;
        local rule = {
            name = ruleName,
            criteria = clone cue._criterias,
            group_params = g_rr.RGroupParams({
                permitrepeats = cue._repeatableResponses,
                sequential = cue._promptResponsesSequentially,
                norepeat = cue._promptResponsesOnce
            }),
            responses = []
        };

        // Check if Cue is triggered by original concept name.
        if (ruleConcept == _name) {
            onlyTriggerOnce = _triggerOnce;
            recordConcept = _record;

            // Check if Cue is remarkable.
            if (_remarkable != null) {
                rule.criteria.append(["concept", "TLK_REMARK"]);
                rule.criteria.append(["subject", ruleConcept]);
                rule.criteria.append(["distance",
                    _remarkable.len() == 1 ? 0 : _remarkable[0],
                    _remarkable.len() == 1  ? _remarkable[0] : _remarkable[1]
                ]);
                rule.criteria.append(["speaking", 0]);
            } else {
                rule.criteria.append(["concept", ruleConcept]);
            }

            // Check if the concept's Rules are randomized.
            if (_randomize) {
                local maxNumber = _cues.len();
                rule.criteria.append([function(query) {
                    local random = floor(maxNumber * query.randomnum / 100);
                    return index == (random >= maxNumber ? maxNumber - 1 : random);
                }]);
            }
            
            // Check if Cue should only be triggered once.
            if (onlyTriggerOnce) {
                local remarkFlag = "worldSaid" + ruleConcept;
                rule.criteria.append([@(query) !(remarkFlag in query) || remarkFlag in query && query[remarkFlag] != 1]);
            }

            rule.criteria.extend(_criterias);
        } else {
            rule.criteria.append(["concept", ruleConcept])
        }

        // Initial scene path
        local scenePath = "npcs/";

        // Check if target is not a playable survivor.
        if (!isValidSurvivor(cue._orator)) {
            rule.criteria.append(["name", cue._orator]);
        } else {
            rule.criteria.append(["who", cue._orator]);
            rule.criteria.append(["is" + cue._orator + "alive", 1])
            // Change scene path to proper survivor.
            scenePath = cue._orator + "/";
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
                if (value._followup != null) {
                    response.followup <- _getFollowup(value._followup);
                }
            }

            // Check if the follow up is empty and the Cue has a defined follow up
            if (!("followup" in response) && cue._followup != null) {
                response.followup <- _getFollowup(cue._followup);
            }

            rule.responses.append(response);
        }

        // print("Created rule with name " + rule.name + ", concept " + ruleConcept + "\n");
        return rule;
    }
}


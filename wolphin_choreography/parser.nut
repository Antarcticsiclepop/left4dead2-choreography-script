/** Not a number. */
local NAN = sqrt(-1);

/** Fixes reference issues. */
local isValidSurvivor = isSurvivor;
local FollowupClass = Followup;
local parserPrint = printQuery;

class Parser {

    /** Parses the Concept to create Rules based on Cues and Sequences. */
    function processConcept() {
        local responseRules = [];

        foreach (index, sequence in _cues) {
            if ("_cues" in sequence) {
                responseRules.extend(parseSequence(sequence, index));
            } else {
                responseRules.append(
                    createResponseRule(_name, getRuleName(index), sequence, index)
                );
            }
        }

        g_rr.rr_ProcessRules(responseRules);
    }

    function parseSequence(sequence, index) {
        local responseRules = [];
        local ruleIndex = 0;
        local cues = sequence._cues;
        local criterias = sequence._criterias;
        local ruleName = getRuleName(index);
        
        // Reverse the cue list as ::pop() will be used
        cues.reverse();

        while (cues.len() > 0) {

            local cue = cues.pop();
            if (!("_delay" in cue)) {
                // The first cue of the sequence adopts the concept name.
                // The rest of the rules get a unique concept name to follow up from the previous cue.
                local ruleConcept = ruleIndex == 0 ? _name : ruleName + ruleIndex.tostring();

                // Add the next followup if any (excludes last cue).
                if (cues.len() > 0) {
                    local delay = 0;

                    while("_delay" in cues.top()) {
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
                local responseRule = createResponseRule(ruleConcept, ruleName + ruleIndex.tostring(), cue, index);
                responseRules.append(responseRule);
                ruleIndex++;
            }
        }

        return responseRules;
    }

    /**
        Generate a unique name for every Cue and Sequence
        from the concept name. (concept_A, concept_B, concept_C...)
    */
    function getRuleName(index) {
        local suffix = "_" + (65 + index).tochar();
        return _name + suffix;
    }

    function getResponseThen(followup) {
        if (followup != null) {
            if (type (followup) == "string") {
                return {
                    concept = followup,
                    target = "any",
                    delay = 0
                };
            } else {
                return {
                    concept = followup._concept,
                    target = followup._target != null ? followup._target : "any",
                    delay = followup._delay != null ? followup._delay : 0
                };
            }
        }
    }

    function createResponseRule(ruleConcept, ruleName, cue, index) {
        local onlyTriggerOnce = false;
        local recordConcept = false;
        local rule = {
            name = ruleName,
            criteria = clone cue._criterias,
            group_params = g_rr.RGroupParams({
                permitrepeats = true,
                sequential = false,
                norepeat = false
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

            if (_criterias != null) {
                rule.criteria.extend(_criterias);
            }
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
            local followup = null;        
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
                followup = getResponseThen(value._followup);
            }

            // Check if the follow up is empty and the Cue has a defined follow up
            if (followup == null) {
                followup = getResponseThen(cue._followup);
            }

            if (followup != null) {
                foreach (target in split(followup.target, "| ")) {
                    local duplicateResponse = clone response;
                    duplicateResponse.followup <- g_rr.RThen(target, followup.concept, {}, followup.delay);
                    rule.responses.append(duplicateResponse);
                }
            } else {
                rule.responses.append(response);
            }
        }

        // print("Created rule with name " + rule.name + ", concept " + ruleConcept + "\n");
        return rule;
    }
}


/** Fixes reference issues. */
local isValidSurvivor = isSurvivor;
local printQuery = printTable;

function criteriaNotSaid(concept) {
    local recordFlag = "worldSaid" + concept;
    return [@(query) !(recordFlag in query) || recordFlag in query && query[recordFlag] != 1];
}

function criteriaAliveAndNear(survivorPredicate, ...) {
    local predicates = [];

    foreach (survivors in split(survivorPredicate, "|")) {
        local predicate = {};

        foreach (survivor in split(survivors, "& ")) {
            if (survivor.tolower() == "any") {
                predicate["disttoclosestsurvivor"] <- [
                    vargv.len() <= 1 ? 0 : vargv[0],
                    vargv.len() == 0 ? 2056 : vargv.len() == 1 ? vargv[0] : vargv[1]
                ];
            } else if (!isValidSurvivor(survivor)) {
                error("Invalid survivor id: " + survivor + "\n");
            } else {
                predicate["is" + survivor.tolower() + "alive"] <- [1, 1];
                predicate["distto" + survivor.tolower()] <- [
                    vargv.len() <= 1 ? 0 : vargv[0],
                    vargv.len() == 0 ? 2056 : vargv.len() == 1 ? vargv[0] : vargv[1]
                ];
            }
        }

        predicates.push(predicate);
    }

    return [function(query) {
        function evaluatePredicate(query, predicate) {
            foreach (key, val in query) {
                local lowerKey = key.tolower();
                if (lowerKey in predicate) {
                    if (val < predicate[lowerKey][0] || val > predicate[lowerKey][1]) {
                        return false;
                    }
                }
            }

            return true;
        }

        foreach (predicate in predicates) {
            if (evaluatePredicate(query, predicate)) {
                return true;
            }
        }

        return false;
    }];
}

function criteriaNotInDanger() {
    return [
        ["coughing", 0],
        ["numberofteamalive", 0, 4],
        ["NumberOfTeamDead", 0, 4],
        ["beingjockeyed", 0],
        ["hangingfromledge", 0],
        ["pouncevictim", 0],
        ["incapacitated", 0],
        ["onfire", 0],
        ["hangingfromtongue", 0],
    ];
}

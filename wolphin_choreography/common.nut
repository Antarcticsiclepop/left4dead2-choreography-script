/**
    Get a random item from a list
*/
function randomItem(list) {
    if (list.len() == 1) {
        return list[0];
    }

    local randomFloat = (1.0 * rand()) / RAND_MAX;
    if (randomFloat == 1.0) {
        return list[list.len() - 1];
    } else {
        return list[(list.len() * randomFloat).tointeger()];
    }
}

/**
    Identifiers of all playable survivors
*/
local SURVIVOR_IDS = ["coach", "gambler", "producer", "mechanic", "biker", "manager", "namvet", "teengirl"];

/**
    Checks if a target is a playable survivor.
*/
function isSurvivor(target) {
    return SURVIVOR_IDS.find(target.tolower()) != null;
}

/**
    For testing purposes, prints the entire table.
*/
function printTable(table) {
    g_ModeScript.DeepPrintTable(table);
    return true;
}

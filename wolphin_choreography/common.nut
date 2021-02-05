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

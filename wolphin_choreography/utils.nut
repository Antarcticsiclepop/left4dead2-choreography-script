local SURVIVOR_IDS = ["coach", "gambler", "producer", "mechanic", "biker", "manager", "namvet", "teengirl"];

function isSurvivor(target) {
    return SURVIVOR_IDS.find(target.tolower()) != null;
}

function getRandomItem(list) {
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

function printTable(table) {
    g_ModeScript.DeepPrintTable(table);
    return true;
}

function getSuffix(number) {
    return number < 0 ? "" : getSuffix((number / 26) - 1) + (65 + number % 26).tochar();
}

function playSoundFile(speaker, query, soundfile, volume = 1.0) {
	if (!IsSoundPrecached( soundfile)) PrecacheSound(soundfile);
	EmitAmbientSoundOn(soundfile, volume, 350, 100, speaker);
}

function emitSound(speaker, query, soundname) {
	EmitSoundOn(soundname, speaker);
}

function getExpresserTarget(value) {
    if (value.tolower() == "namvet")
        return "NamVet";
    else if (value.tolower() == "teengirl")
        return "TeenGirl";
    else {
        return value.slice(0,1).toupper() + value.slice(1);
    }
}

function getWorldContextValue(query, context) {
    local worldContext = "world" + context;
    return worldContext in query ? query[worldContext] : 0;
}

function setWorldContext(context, value = 1, duration = -1) {
    Entities.FindByClassname(null, "worldspawn").SetContext(context, value.tostring(), duration);
}

function addToWorldContext(query, context, value = 1, duration = -1) {
    setWorldContext(context, getWorldContextValue(query, context) + value, duration);
}

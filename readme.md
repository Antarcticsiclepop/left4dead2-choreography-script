# Wolphin's Left 4 Dead 2 Choreography Script

This script makes it easy to create your own dialogues between the survivors and NPCs for custom levels!

[![image](https://steamuserimages-a.akamaihd.net/ugc/1750180860340150359/F48B3520F51B0FB714B7E9F6126E3DD56B5C799B/)](https://steamcommunity.com/workshop/filedetails/?id=2382842747)

> [Subscribe](https://steamcommunity.com/workshop/filedetails/?id=2382842747) to the workshop item to starting writing dialogue scripts for your custom levels.

> You'll need to add this addon as **required workshop item** for your dialogues to work on your custom levels!

# Creating your dialogue script

Create a new `.nut` file under the `scripts` folder, I recommend using a similiar name as your custom level and suffix it with *_choreo*.

Import the choreographic script at the beginning of your script file:

```javascript
IncludeScript("wolphin_choreography");
```

Click the links below to learn how to create dialogues:

* [Writing a `Concept` object](documentation/concept.md) 🎬
    * [Writing a `Cue` object](documentation/cue.md)
    * [Writing a `Sequence` object](documentation/sequence.md)
        * [Writing `Criterias`](documentation/criterias.md)
        * [Writing a `Response` object](documentation/response.md) 📣
        * [Writing a `Followup` object](documentation/followup.md)

# Loading your dialogue script in your custom level

To load your dialogue script to your level, add the following outputs to a `info_gamemode` entity:

```
My output named                 OnCoopPostIO
Target entities named           @director
Via this input                  RunScriptFile
With a parameter override of    example_choreo
```

```
My output named                 OnVersusPostIO
Target entities named           @director
Via this input                  RunScriptFile
With a parameter override of    example_choreo
```

# How to trigger a **concept**

There are many ways to trigger a **concept**, but a *remarkable* **concept** can only be triggered by *remarkable entities*:

## **By *func_orator* entity**

Use a entity to trigger the following output:

```
My output named                 <any>
Target entities named           func_orator
Via this input                  SpeakResponseConcept
With a parameter override of    <concept_name>
```

## **By *info_director* entity**

Use a entity to trigger the following output:

```
My output named                 <any>
Target entities named           info_director
Via this input                  FireConceptToAny
With a parameter override of    <concept_name>
```

## **By interactable entity**

Use a interable entity (ex. `func_button`) to trigger the output:

```
My output named                 OnPressed
Target entities named           !activator
Via this input                  SpeakResponseConcept
With a parameter override of    <concept_name>
```

## **By *ent_fire* command**

Write a script that executes the following command:

```
EntFire("info_director", "FireConceptToAny", "<concept_name>", 0.0);
EntFire("func_orator", "SpeakResponseConcept", "<concept_name>", 0.0);
```

## **By *info_remarkable* entity**

Create a `info_remarkable` with the following propery:

```
Subject context                 <concept_name>
```

# Helpful tips

## **How to reload your dialogue script in-game by command**

```
script_execute example_choreo
```

## **How to trigger a concept from console**

For **concepts** targeting survivors (you will not be able to prompt **cues** for the survivor you are in control):
```
ent_fire info_director FireConceptToAny <concept_name>
```

To trigger a **concept** for the current survivor you are in control:
```
ent_fire !self SpeakResponseConcept <concept_name>
```

For **concepts** targeting orator entities:
```
ent_fire func_orator SpeakResponseConcept <concept_name>
```

## **Use the game's subtitle files to find scenes**

You can use the subtitle files of the game to find scenes you are looking for and ones you've never seen before, subtitle identifiers for survivors are written as `<survivor_name>_<scene_name>`, for npcs the subtitle identifier is the entire scene name. Example:

```javascript
"Coach_WorldC4M208"	"<clr:112,75,125>Coach: Dang. Bitches must like sugar." // "WorldC4M208" is the scene name
"Virgil_C4End14"	"<clr:148,148,110>Virgil: Woo, look out now, that big fella, there!" // "Virgil_C4End14" is the scene name
```

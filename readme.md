# Wolphin's Left 4 Dead 2 Choreography Script

This script makes it easy to create your own dialogues between the survivors and orators for custom levels!

Subscribe to the workshop item to starting writing choreographic scripts for your custom levels:
https://steamcommunity.com/workshop/filedetails/?id=2382842747

You'll need to add this addon as **Required DLC** for your dialogues to work on your custom levels!

# Creating your choreographic script

Create a new `.nut` file under the `scripts` folder, I recommend using a similiar name as your custom level and suffix it with *_choreo*.

Import the choreographic script at the beginning of your script file:

```javascript
IncludeScript("wolphin_choreography");
```

Click the links below to learn how to create dialogues:

* [Writing a `Concept` object](documentation/concept.md)
* [Writing a `Cue` object](documentation/cue.md)
* [Writing a `Response` object](documentation/response.md)
* [Writing a `Followup` object](documentation/followup.md)
* [Writing a `Sequence` object](documentation/sequence.md)
* [Writing criterias](documentation/criterias.md)

# Loading your dialogue script in your custom level

To load your choreographic script to your level, add the following outputs to a `info_gamemode` entity:

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
Target entities named           <func_orator_name>
Via this input                  SpeakResponseConcept
With a parameter override of    <concept_name>
```

## **By *info_director* entity**

Use a entity to trigger the following output:

```
My output named                 <any>
Target entities named           <info_director_name>
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
EntFire("<info_director_name>", "FireConceptToAny", "<concept_name>", 0.0);
EntFire("<func_orator_name>", "SpeakResponseConcept", "<concept_name>", 0.0);
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

For **concepts** targeting survivors (you will not be able to prompt cues for the survivor you are in control):

```
ent_fire <info_director_name> FireConceptToAny <concept_name>
```

For **concepts** targeting orator entities:

```
ent_fire <func_orator_name> SpeakResponseConcept <concept_name>
```

## **Use the game's subtitle files to find scenes**

You can use the subtitle files of the game to find scenes you are looking for and ones you've never seen before, subtitle identifiers for survivors are written as `<survivor_name>_<scene_name>`, for npcs the subtitle identifier is the entire scene name. Example:

```javascript
"Coach_WorldC4M208"	"<clr:112,75,125>Coach: Dang. Bitches must like sugar." // "WorldC4M208" is the scene name
"Virgil_C4End14"	"<clr:148,148,110>Virgil: Woo, look out now, that big fella, there!" // "Virgil_C4End14" is the scene name
```

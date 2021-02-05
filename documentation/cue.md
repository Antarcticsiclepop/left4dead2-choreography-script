# Writing a `Cue::` object

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .responses(
            ...
        )
);
```

This is an example of a `Cue::` object with the orator *gambler* (a.k.a. Nick), a `Cue::` object must contain one or more **responses**. A single **response** will be prompted at random if the `Cue::` object's **criterias** are met. By default, as a criteria, the orator must be alive/exist.

The list of survivors names are as follows:

```javascript
"coach", "gambler", "producer", "mechanic", "biker", "manager", "namvet", "teengirl"
```

## **`::criterias()`**

Using this function will define criterias the **cue** must meet for the **responses** to prompt. Example:

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .criteras(
            criteriaNotInDanger()
        )
        ...
);
```

> There is a bug where **cues** with more criterias will have higher priority when evaluating, it's recommended to keep the same amount of criteras for all `Cue::` objects.

## **`::followup()`**

Using this function will trigger another **concept** after any of its **responses** has successfully prompted. Example:

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .followup("SomeNextConcept")
        ...
);
```

## **`::repeatableResponse()`**

Using this function will make the **cue** prompt any **response** even if it has been recently prompted when triggered. Example:

> By default, every **response** is prompted atleast once before repeating.

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .repeatableResponse()
        ...
);
```

## **`::promptResponseSequentially()`**

Using this function will make the **cue** prompt the **responses** in sequential order rather than randomly. Example:

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .promptResponseSequentially()
        ...
);
```

## **`::promptResponseOnce()`**

Using this function will make the **cue** prompt each **response** only once (it will not be able to prompt that **response** again). Example:

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .promptResponseOnce()
        ...
);
```

> There is a bug where **responses** of a **cue** will be marked as played (when using this function) even when another **cue's response** was prompted, this is because of how the game handles the **cue** execution.
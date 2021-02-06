# Writing a `Cue::` object

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .responses(
            ...
        )
);
```

This is an example of a `Cue::` object with the **actor** *gambler* (a.k.a. Nick), a `Cue::` object must contain one or more **responses**. A single **response** will be prompted at random if the `Cue::` object's **criterias** are met. By default, as a criteria, the **actor** must be alive/exist.

The list of survivors names are as follows:

```javascript
"coach", "gambler", "producer", "mechanic", "biker", "manager", "namvet", "teengirl"
```

## **`::criterias()`**

Using this function will define criterias the **cue** must meet for the **responses** to prompt. Example:

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .criteras(
            criteriaNotInDanger()
        )
        ...
);
```

> There is a bug where **cues** with more criterias will have higher priority when evaluating, it's recommended to keep the same amount of criteras for all `Cue::` objects.

## **`::followups()`**

Using this function will trigger another **concept** after any of its **responses** has successfully prompted. The **followups** of the `Cue::` object will not be overwrite the **followups** of the `Response::` object. Example:

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .followups("SomeNextConcept")
        ...
);
```

> You can have more than one `Followup::` object, only one will trigger.

## **`::callback()`**

Using this function will allow you to provide a callback function that will execute after any of the **responses** has prompted. The **callback** of the `Cue::` object will not be overwrite the **callback** of the `Response::` object. Example:

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .callback(@() printl("Hello world!"))
        ...
);
```

> You can have more than one `Followup::` object, only one will trigger.

## **`::repeatableResponses()`**

Using this function will make the **cue** prompt any **response** even if it has been recently prompted when triggered. Example:

> By default, every **response** is prompted atleast once before repeating.

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .repeatableResponses()
        ...
);
```

## **`::promptResponsesSequentially()`**

Using this function will make the **cue** prompt the **responses** in sequential order rather than randomly. Example:

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .promptResponsesSequentially()
        ...
);
```

## **`::promptResponsesOnce()`**

Using this function will make the **cue** prompt each **response** only once (it will not be able to prompt that **response** again). Example:

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .promptResponsesOnce()
        ...
);
```

# Writing a `Followup::` object

```javascript
Cue()
    .orator("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
    )
    .responses("Worldc4m117")

- or -

Cue()
    .orator("gambler")
    .responses(
        Response()
            .scene("Worldc4m117")
            .followup(
                Followup()
                    .concept("SomeNextConcept")
            )
    )
```

A `Followup::` object will allow you to add more options after a scene has finished rather than using direct **concept** names.

## **`::target()`**

Using this function will make it a **criteria** whom the orator must be for to the next **concept** . Example:

```javascript
Cue()
    .orator("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
            .target("gambler")
    )
    .responses("Worldc4m117")
```

You can add multiple orators as a target by adding a `|` symbol. Example:

```javascript
Cue()
    .orator("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
            .target("gambler | producer | mechanic")
    )
    .responses("Worldc4m117")
```

## **`::delay()`**

Using this function will add a delay before the next **concept** is triggered. Example:

```javascript
Cue()
    .orator("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
            .delay(2.0)
    )
    .responses("Worldc4m117")
```

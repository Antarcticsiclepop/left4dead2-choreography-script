# Writing a `Followup::` object

```javascript
Cue()
    .actor("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
    )
    .responses("Worldc4m117")

- or -

Cue()
    .actor("gambler")
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

Using this function will make it a **criteria** whom the **actor** must be for to the next **concept** . Example:

```javascript
Cue()
    .actor("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
            .target("gambler")
    )
    .responses("Worldc4m117")
```

You can add multiple targets as parameters, one will be randomly chosen. Example:

```javascript
Cue()
    .actor("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
            .target("gambler" "producer" "mechanic")
    )
    .responses("Worldc4m117")
```

## **`::delay()`**

Using this function will add a delay before the next **concept** is triggered. Example:

```javascript
Cue()
    .actor("gambler")
    .followup(
        Followup()
            .concept("SomeNextConcept")
            .delay(2.0)
    )
    .responses("Worldc4m117")
```

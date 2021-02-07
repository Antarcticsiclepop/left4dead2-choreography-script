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
            .target("self")
    )
    .responses("Worldc4m117")
```

You can add multiple targets as parameters, one will be randomly chosen. Example:

```javascript
Followup()
    .concept("SomeNextConcept")
    .target("gambler" "producer" "orator")
```

### **List of targets**

* `<survivor_name>` - Target a specific survivor.
* `<orator_name>` - Target a specific func_orator.
* `all` - Target all speakers (survivor and func_orator).
* `self` - Target the same speaker from the response (survivor or func_orator).
* `any` - Target any survivor. Default option.
* `subject`
* `from`
* `func_orator` - Target the first func_orator found.

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

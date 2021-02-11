# Writing a `Followup::` object

```javascript
Response()
    .scene("Worldc4m117")
    .followups("SomeNextConcept")

- or -

Response()
    .scene("Worldc4m117")
    .followups(
        Followup()
            .concept("SomeNextConcept")
    )
```

A `Followup::` object will allow you to add more options after a scene has finished rather than using direct **concept values**.

## **`::target()`**

Function will target whom the **actor** must be for to the next **concept** and invoke it. Example:

```javascript
Cue()
    .actor("gambler")
    .followups(
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
* `subject` - Target the survivor being looked at.
* `from` - Same as `self`. *I think.*
* `func_orator` - Target the first func_orator found.

## **`::delay()`**

Function will add a delay before the next **concept** is invoked. Example:

```javascript
Cue()
    .actor("gambler")
    .followups(
        Followup()
            .concept("SomeNextConcept")
            .delay(2.0)
    )
    .responses("Worldc4m117")
```

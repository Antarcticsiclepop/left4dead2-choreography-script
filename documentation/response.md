# Writing a `Response::` object

```javascript
.publishCues(
    Cue()
        .actor("coach")
        .responses(
            "Worldc4m105" // Man... I sure wish the burger tank was open.
            "Worldc4m106" // I sure wish the burger tank was open.
        )
);

- or -

.publishCues(
    Cue()
        .actor("coach")
        .responses(
            Response()
                .scene("Worldc4m105") // Man... I sure wish the burger tank was open.
            Response()
                .scene("Worldc4m106") // I sure wish the burger tank was open.
        )
);
```

A `Reponse::` object will allow you to add more options after a scene has finished, rather than using direct scene names.

## **`::followups()`**

Using this function will trigger another **concept** after the **response** has successfully prompted . Example:

```javascript
.publishCues(
    Cue()
        .actor("gambler")
        .responses(
            Response()
                .scene("Worldc4m117") // This is the best goddamn burger tank I’ve ever visited.
                .followups("SomeNextConcept")
        )
);
```

This is useful when you need different **followups** for every **response**. The **followup** of the `Response::` object will not be overwritten by the **followup** of the `Cue::`.

> You can have more than one `Followup::` object, only one will trigger.
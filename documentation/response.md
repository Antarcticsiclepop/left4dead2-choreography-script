# Writing a `Response::` object

```javascript
.publishCues(
    Cue()
        .orator("coach")
        .responses(
            "Worldc4m105" // Man... I sure wish the burger tank was open.
            "Worldc4m106" // I sure wish the burger tank was open.
        )
);

- or -

.publishCues(
    Cue()
        .orator("coach")
        .responses(
            Response()
                .scene("Worldc4m105") // Man... I sure wish the burger tank was open.
            Response()
                .scene("Worldc4m106") // I sure wish the burger tank was open.
        )
);
```

A `Reponse::` object will allow you to add more options after a scene has finished, rather than using direct scene names.

## **`::followup()`**

Using this function will trigger another **concept** after the **response** has successfully prompted . Example:

```javascript
.publishCues(
    Cue()
        .orator("gambler")
        .responses(
            Response()
                .scene("Worldc4m117") // This is the best goddamn burger tank I’ve ever visited.
                .followup("SomeNextConcept")
        )
);
```

This is useful when you need different **followups** for every **response**. The **followup** of the `Response::` object will not be overwritten by the **followup** of the `Cue::`.

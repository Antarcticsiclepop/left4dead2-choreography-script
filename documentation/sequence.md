# Writing a `Sequence::` object

A `Sequence::` object can be used as a quick way to trigger multiple **cues** in a sequential order. Example:

```javascript
.publishCues(
    Sequence()
        .cues(
            Cue()
                .orator("coach")
                .responses(           
                    "Worldc4m105" // Man... I sure wish the burger tank was open.
                    "Worldc4m106" // I sure wish the burger tank was open.
                )
            Cue()
                .orator("coach") // I could go for a barbecue bacon burger.
                .responses("Worldc4m107")
            Cue()
                .orator("coach")
                .responses("Worldc4m108") // And a large order of fries.
            Cue()
                .orator("coach")
                .responses("Worldc4m109") // Orange soda with no ice.
            Cue()
                .orator("coach")
                .responses("Worldc4m110") // And a piece of hot apple pie.
            Cue()
                .orator("coach")
                .responses("Worldc4m111") // Goddamn I miss burger tank.
        )
);
```

You may add a **followup** to the last `Cue::` object of the **sequence**.

## **`::criterias()`**

Using this function will set the same criterias to every **cue** of the **sequence**, the **criterias** of a `Cue::` object will not be overwritten.

```javascript
.publishCues(
    Sequence()
        .criterias(
            criteriaNotInDanger()
            criteriaAliveAndNear("any")
        )
        ...
);
```

## **`Delay::`**

You can add delays between `Cue::` objects by using a `Delay::` object, example:

```javascript
Sequence()
    .cues(
        Cue()
            .orator("coach")
            .responses(           
                "Worldc4m105" // Man... I sure wish the burger tank was open.
                "Worldc4m106" // I sure wish the burger tank was open.
            )
        Delay(2.0)
        Cue()
            .orator("coach") // I could go for a barbecue bacon burger.
            .responses("Worldc4m107")
        ...
    )
```


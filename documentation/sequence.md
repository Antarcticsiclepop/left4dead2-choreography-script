# Writing a `Sequence::` object

A `Sequence::` object can be used as a quick way to trigger multiple **cues** in a sequential order. Example:

```javascript
.publishCues(
    Sequence()
        .cues(
            Cue()
                .actor("coach")
                .responses(           
                    "Worldc4m105" // Man... I sure wish the burger tank was open.
                    "Worldc4m106" // I sure wish the burger tank was open.
                )
            Cue()
                .actor("coach") // I could go for a barbecue bacon burger.
                .responses("Worldc4m107")
            Cue()
                .actor("coach")
                .responses("Worldc4m108") // And a large order of fries.
            Cue()
                .actor("coach")
                .responses("Worldc4m109") // Orange soda with no ice.
            Cue()
                .actor("coach")
                .responses("Worldc4m110") // And a piece of hot apple pie.
            Cue()
                .actor("coach")
                .responses("Worldc4m111") // Goddamn I miss burger tank.
        )
);
```

You may add **followups** to any `Cue::` object of the **sequence** for branching out to other **concepts** rather than continuing down the sequence.

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
            .actor("coach")
            .responses(           
                "Worldc4m105" // Man... I sure wish the burger tank was open.
                "Worldc4m106" // I sure wish the burger tank was open.
            )
        Delay(2.0)
        Cue()
            .actor("coach") // I could go for a barbecue bacon burger.
            .responses("Worldc4m107")
        ...
    )
```


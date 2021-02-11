# Writing a `Concept::` object

```javascript
Concept()
    .value("InBurgerTank")
    .publishCues(
        ...
    );
```

This is an example of a `Concept::` object with the value **InBurgerTank**, each `Concept::` object must have unique value which is used to trigger its **cues**, a `Concept::` object can have one or more `Cue::` objects. Every **cue** will be evaluated when the **concept** is triggered, when more than one **cue**'s criterias are satisfied, a random **response** will be selected.

The first **cue** of a `Sequence::` object is assocciated to the created **concept**, the remainder **cues** of the `Sequence::` object will be assocciated to a randomly generated **concept** for **followups**.

> The `::publishCues()` function must be the last callback.

## **`::remarkable()`**

Function will allow the **cues** to be triggered by an **info_remarkable** entity. Example:

```javascript
Concept()
    .value("InBurgerTank")
    .remarkable(256)
    ...
```

> When a **info_remarkable** entity successfully prompts a **response**, the entity will no longer invoke the **concept**, but the **concept** can be invoked again by another **info_remarkable**.

```javascript
/**
* @param MAX_DISTANCE Number that represents the maximum distance to trigger a `info_remarkable` entity
*/
remarkable(MAX_DISTANCE)

/**
* @param {number} MIN_DISTANCE The minimum distance to trigger a `info_remarkable` entity
* @param {number} MAX_DISTANCE The maximum distance to trigger a `info_remarkable` entity
*/
remarkable(MIN_DISTANCE, MAX_DISTANCE)
```

## **`::triggerOnce()`**

Function will restrict the **cues** within the `Concept::` object from triggering again after any has successfully prompted a **response**. Example:

```javascript
Concept()
    .value("InBurgerTank")
    .triggerOnce()
    ...
```

## **`::record()`**

Function will store the `Concept::` value in the **context table** which can then be used as a **criteria** for the **cues**. This is the method in how a **cue** is only allowed to be triggered once, if the **concept** exists in the **context table**, the evaluation will fail. Example:

```javascript
Concept()
    .value("InBurgerTank")
    .record()
    ...
```

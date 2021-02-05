# Writing a `Concept::` object

```javascript
Concept()
    .name("InBurgerTank")
    .publishCues(
        ...
    );
```

This is an example of a `Concept::` object with the name **InBurgerTank**, each `Concept::` object must have unique name which is used to trigger its **cues**, a `Concept::` object can have one or more `Cue::` objects. Every **cue** will be evaluated in a random arrangement when the **concept** is triggered, the first one that satify their criteras will be prompted.

The first **cue** of a `Sequence::` object is assocciated to the created **concept**, the remainder **cues** of the `Sequence::` object will be assocciated to a randomly generated **concept** for **followups**.

> The `::publishCues()` function must be the last callback.

## **`::remarkable()`**

Using this function will allow the **cues** to be triggered by an **info_remarkable** entity. Example:

```javascript
Concept()
    .name("InBurgerTank")
    .remarkable(256)
    ...
```

> When a **info_remarkable** enttity successfully triggers a **response**, the entity will no longer trigger the **concept**, but the **concept** can used again with another **info_remarkable**.

```javascript
/**
* @param MAX_DISTANCE Number that represents the maximum distance to trigger a `info_remarkable` entity
*/
remarkable(MAX_DISTANCE)

/**
* @param MIN_DISTANCE Number that represents the minimum distance to trigger a `info_remarkable` entity
* @param MAX_DISTANCE Number that represents the maximum distance to trigger a `info_remarkable` entity
*/
remarkable(MIN_DISTANCE, MAX_DISTANCE)
```

## **`::triggerOnce()`**

Using this function will restrict the **cues** from triggering again after any has successfully prompted a **response**. Example:

```javascript
Concept()
    .name("InBurgerTank")
    .triggerOnce()
    ...
```

## **`::record()`**

Using this function will store the `Concept::` object's name in the world table which can then be used as a **criteria**. This is the method in how a **cue** is only allowed to be triggered once, if the **concept** exists in the world table, the evaluation will fail. Example:

```javascript
Concept()
    .name("InBurgerTank")
    .record()
    ...
```

## **`::criterias()`**

Using this function will append additional criterias to the **cues** belonging to the **concept** (won't be added to the remainder **cues** of a `Sequence::` object), this is useful to reduce repetition. Example:

```javascript
Concept()
    .name("InBurgerTank")
    .criterias(
        criteriaNotSaid("SomeOtherConcept")
    )
    ...
```

## **Knowns bugs**

* There cannot be more than one `Cue::` object with the same **actor** under the same `Concept::` object.

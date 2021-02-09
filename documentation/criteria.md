# Writing **criterias**

Criterias are compared with a **context table**, you can write **criterias** that are compared with a single value or a range of values:

```javascript
Cue()
    .criterias(
        ["coughing", 0],
        ["numberofteamalive", 0, 4],
        ["activeweapon", "SecondPistol"]
    )
```

# Available custom criterias

## **`WCScript::criteriaNotSaid()`**

Halts the **cue** from triggering if some other **concept** has already prompted a **cue** by looking in the **world's context table**, use the `Concept::record()` function to store the **concept** when prompted.

```javascript
.criterias(
    /**
    * @param {string} OTHER_CONCEPT A concept
    */
    criteriaNotSaid(OTHER_CONCEPT)
)
```

## **`WCScript::criteriaWorldNotValue()`**

Halts the **cue** from triggering if a created **context** equals a value.

```javascript
.criterias(
    /**
    * @param {string} CONTEXT A context
    * @param {number | string} VALUE The context value
    */
    criteriaWorldNotValue(CONTEXT, VALUE)
)
```

## **`WCScript::criteriaNotInDanger()`**

A collection of the following **criterias**:

*    ["coughing", 0]
*    ["numberofteamalive", 0, 4]
*    ["NumberOfTeamDead", 0, 4]
*    ["beingjockeyed", 0]
*    ["hangingfromledge", 0]
*    ["pouncevictim", 0]
*    ["incapacitated", 0]
*    ["onfire", 0]
*    ["hangingfromtongue", 0]

```javascript
.criterias(
    criteriaNotInDanger()
)
```

## **`WCScript::criteriaAliveAndNear()`**

Useful for restricting cues that require certain survivors to be alive and near one another.

```javascript
.criterias(
    /**
    * @param {string} SURVIVORS
    *        - Check if multiple survivors are alive, ex. "gambler & mechanic & producer"
    *        - Check if any of the following survivors are alive, ex. "gambler | mechanic"
    *        - Check if any of the following group of survivors are alive, ex. "gambler & mechanic | gambler & coach"
    *        - Check if any survivor is alive, ex. "any"
    * @param {number} MIN_DISTANCE The minimum distance from the actor to another survivor
    * @param {number} MAX_DISTANCE The maximum distance from the actor to another survivor
    */
    criteriaNotInDanger(SURVIVORS, MIN_DISTANCE, MAX_DISTANCE)
)
```

# Writing custom criterions

Create your own **criterions** by creating a function to be used as a **criteria**, your function must return **true** or **false**. Example:

```
Cue()
    .criterias(
        [@(query) "worldMyContext" in query && query["worldMyContext"] > 10]
    )
    .actor("coach")
    ...
```

> The **query** parameter is required for your function.

# Example of the **context table**

```
numberinsafespot                = 4
health                          = 100
SPITTERsKilled                  = 0
CurrentTemporaryHealth          = 0
hasfirstaidkit                  = 0
CHARGERsKilled                  = 0
numberofteamalive               = 4
InCombatMusic                   = 0
NORMALsKilled                   = 0
WITCHsKilled                    = 0
BOOMERsKilled                   = 0
TANKsKilled                     = 0
NumberOfTeamDead                = 0
gamemode                        = "coop"
classname                       = "player"
disttoclosestsurvivor           = 59.8
Sneaking                        = 0
instartarea                     = 1
LowViolence                     = 0
worldjoinlast                   = 5
map                             = "dprm1_milltown_a"
healthfrac                      = 1
MovementSpeed                   = 0
NumberOfTeamIncapacitated       = 0
onfire                          = 0
haspainpills                    = 0
hasgrenade                      = 0
is_console                      = 0
team                            = "Survivor"
speaking                        = 0
skill.cfg                       = 1
ZombiesKilledWhileIncapacitated = 0
timesincecombat                 = 99999.9
ClosestSurvivor                 = "Producer"
IncapacitatedCount              = 0
IsIncapacitated                 = 0
CurrentHealth                   = 100
hasmolotov                      = 0
campaignrandomnum               = 44
randomnum                       = 61
HUNTERsKilled                   = 0
inbattlefield                   = 0
numberoutsidesafespot           = 0
intensity                       = 0
Coughing                        = 0
hangingfromtongue               = 0
insafespot                      = 1
incheckpoint                    = 0
timesincegroupincombat          = 99999.9
activeweapon                    = "SecondPistol"
Name                            = 0
beinghealed                     = 0
campaign                        = "unknown"
JOCKEYsKilled                   = 0
onthirdstrike                   = 0
introactor                      = "Zoey"
SMOKERsKilled                   = 0
TimeAveragedIntensity           = 0
```
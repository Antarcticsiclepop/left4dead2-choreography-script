# Writing **criterias**

You can write **criterias** that are compared with a single value or a range of values:

```javascript
Cue()
    .criterias(
        ["coughing", 0],
        ["numberofteamalive", 0, 4],
        ["activeweapon", "SecondPistol"]
    )
```

# Available custom criterias

## **`criteriaNotSaid()`**

Halts a **concept** from triggering if some other **concept** has already prompted.

```javascript
.criterias(
    /**
    * @param OTHER_CONCEPT String that represents the name of a Concept
    */
    criteriasNotSaid(OTHER_CONCEPT)
)
```

## **`criteriaNotInDanger()`**

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

## **`criteriaAliveAndNear()`**

Useful for restricting cues that require certain survivors to be alive and near one another.

```javascript
.criterias(
    /**
    * @param SURVIVORS String
    *        - Check if multiple survivors are alive, ex. "gambler & mechanic & producer"
    *        - Check if any of the following survivors are alive, ex. "gambler | mechanic"
    *        - Check if any of the following group of survivors are alive, ex. "gambler & mechanic | gambler & coach"
    *        - Check if any survivor is alive, ex. "any"
    * @param MIN_DISTANCE Number that represents the minimum distance from the orator to another survivor
    * @param MAX_DISTANCE Number that represents the maximum distance from the orator to another survivor
    */
    criteriaNotInDanger(SURVIVORS, MIN_DISTANCE, MAX_DISTANCE)
)
```

# Writing custom criterias

TO-DO

# List of known criterias

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
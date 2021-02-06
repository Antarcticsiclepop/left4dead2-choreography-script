IncludeScript("wolphin_choreography");

Concept()
    .name("VirgilGetGas")
    .publishCues(
        Cue()
            .actor("orator")
            .responses(
                // I don’t get off the boat, y’all gonna have to get the gasoline and get back here.
                "virgil_C4start14"
                //  I don’t get off the boat, y’all gonna have to get the gas and get back here.
                "virgil_C4start15"
                //  I don’t get off the boat now, ya’ll gonna have to get the gasoline and get back here.
                "virgil_C4start16"
                // Y’all gonna have to get the gas, and come back here, I don’t get off the boat.
                "virgil_C4start17"
                // Ya’ll gonna get the gas and come back here, Virgil don’t get off the boat.
                "virgil_C4start18"
                // Virgil don’t get off the boat, ya’ll gonna have to get the gas and come back here.
                "virgil_C4start19"
            )
            .followups(
                Followup()
                    .concept("VirgilGetGasResponse")
                Followup()
                    .concept("VirgilWaitGasResponse")
                    .target("orator")
                    .delay(0.5)
                Followup()
                    .concept("VirgilSignalResponse")
                    .target("orator")
                    .delay(0.5)
            )
    );

Concept()
    .name("VirgilGetGasResponse")
    .publishCues(
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler")
            )
            .cues(
                Cue()
                    .actor("producer")
                    .responses("Worldc4m112") // We’ll signal him when we get back.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m113") // Do we trust that guy to come back?
                Cue()
                    .actor("producer")
                    .responses("Worldc4m114") // Well I don’t know Nick, I learned to trust you.
                Cue()
                    .actor("producer")
                    .responses("Worldc4m115") // So what do I know?
                Cue()
                    .actor("gambler")
                    .responses(
                        "Worldc4m114" // Fair enough, you're the first three people in the world I have ever trusted.
                        "Worldc4m115" // Shit I don’t even trust myself.
                        "Worldc4m116" // In the case, I don’t think we can trust your judgement in this matter.
                    )
                Cue()
                    .actor("producer")
                    .responses("Worldc4m1b05") // Let’s just get this done and get back.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m109") // Good idea, storms coming.
            )
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("producer & coach")
            )
            .cues(
                Cue()
                    .actor("gambler")
                    .responses(
                        // Stay away from the shore until we signal ya.
                        "Worldc4m110"
                        // Stay off shore until we signal ya.
                        "Worldc4m111"
                        // We’ll signal you when you should return.
                        "Worldc4m112"
                    )
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m119") // Gas station is across the street.
                Cue()
                    .actor("producer")
                    .responses("Worldc4m113") // Do you trust that guy?,
                Cue()
                    .actor("coach")
                    .responses(
                        // Don’t think we’ve got much choice in the matter.
                        "Worldc4m101"
                        // He’s good people.
                        "Worldc4m102"
                    )
                    .followups("VirgilGetGasEnd")
            )
    );

Concept()
    .name("VirgilGetGasEnd")
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m107" // Let’s do this quick and get back on the dam boat.
                "Worldc4m108" // Let’s hurry up and do this before the storm hits.
            )
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses("Worldc4m1b09") // Hey, we should hurry before it starts to rain.
    );

Concept()
    .name("VirgilSignalResponse")
    .publishCues(
        Cue()
            .actor("orator")
            .responses(
                // Signal at me when you get the gas.
                "virgil_C4start01"
                // Now y'all signal me when you get the gasoline now.
                "virgil_C4start02"
                // When y’all get the gasoline, signal me.
                "virgil_C4start03"
                // Signal me when you get the gasoline.
                "virgil_C4start04"
            )
            .followups("VirgilSignalResponse")
        Cue()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("mechanic & coach")
            )
            .actor("gambler")
            .responses(
                Response()
                    .scene("Worldc4m1b01") // What are we supposed to signal him with?
                    .followups("VirgilSignalRespondQuestion")
                Response()
                    .scene("Worldc4m1b05") // There’s flares in the gun bag.
                    .followups("VirgilSignalQuestion")
            )
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler & mechanic & producer")
            )
            .cues(
                Cue()
                    .actor("coach")
                    .responses("Worldc4m1b07") // We should be in and out of here, get the gas, get back to shore, signal Virgal with the flare gun in the gun bag, then we should just.. oh hell, tell me someone brought the gun bag.
                Cue()
                    .actor("producer")
                    .responses("Worldc4m1b01") // I could tell you someone named Ellis brought the gun bug like he was supposed to, but I would be lying.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b06") // You didn’t grab the guns!?
                Cue()
                    .actor("mechanic")
                    .responses("Worldc4m1b06") // No.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b04") // Great, we’re screwed.
                Cue()
                    .actor("producer")
                    .responses("Worldc4m1b02") // I never thought I’d miss a gun so much.
                Cue()
                    .actor("coach")
                    .responses("Worldc4m1b05") // Look here, the gas station is right across the street, we could have been back by now, come on.
            )
    );

Concept()
    .name("VirgilSignalRespondQuestion")
    .publishCues(
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler & coach")
            )
            .cues(
                Cue()
                    .actor("mechanic")
                    .responses("Worldc4m1b01") // Oh there’s flares in the gun bag.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b02") // What gun bag?
                Cue()
                    .actor("mechanic")
                    .responses("Worldc4m1b02") // You didn’t grab the guns?
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b03") // Me!? Who died and made me a gun monitor?
                Cue()
                    .actor("mechanic")
                    .responses("Worldc4m1b04") // Pretty much everybody.
                Cue()
                    .actor("coach")
                    .responses("Worldc4m1b01") // Look here the gas station is right across the street, we could have been back by now, come on.
            )
    );

Concept()
    .name("VirgilSignalQuestion")
    .publishCues(
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler & mechanic")
            )
            .cues(
                Cue()
                    .actor("coach")
                    .responses("Worldc4m1b06") // What gun bag? Oh for - Tell me we didn’t forget the guns.
                Cue()
                    .actor("mechanic") // You didn’t grab the gun bag?
                    .responses("Worldc4m1b03")
                Cue()
                    .actor("coach")
                    .responses("Worldc4m1b02") // Me? I told Nick to grab the guns.
                Cue()
                    .actor("mechanic")
                    .responses("Worldc4m1b05") // Why didn’t you grab them?
                Cue()
                    .actor("coach")
                    .responses(
                        "Worldc4m1b03" // Look I’m a generously proportioned man, getting off a rocking boat takes concentration.
                        "Worldc4m1b04" // Look I’m a generously proportioned man, getting off a rocking boat takes concentration.
                    ) 
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b07") // The gas station is right across the street, let’s just get the gas then we’ll figure out how to signal virgil.
            )
    );
   
Concept()
    .name("VirgilWaitGasResponse")
    .publishCues(
        Cue()
            .actor("orator")
            .responses(
                // Hurry back with the gas I’ll be waiting.
                "virgil_C4start05"
                // Hurry back with the gasoline I’ll be waiting here.
                "virgil_C4start06"
                // I’ll be right here for ya now, hurry back with the gasoline.
                "virgil_C4start07"
                // Now you hurry back with that gasoline, I’ll be right here.
                "virgil_C4start08"
                // I’ll anchor the boat right here offshore looking for ya.
                "virgil_C4start09"
                // Now I’ll just be just right here offshore looking for ya.
                "virgil_C4start10"
                // Now I’ll anchor right here offshore waiting for ya.
                "virgil_C4start11"
                // I’ll anchor the boat right here offshore waiting for ya.
                "virgil_C4start12"
                // I’ll throw the anchor just offshore waiting for ya.
                "virgil_C4start13"
            )
            .followups("VirgilWaitGasResponse")
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler")
            )
            .cues(
                Cue()
                    .actor("producer")
                    .responses(
                        "Worldc4m101" // This should be easy.
                        "Worldc4m102" // Okay this should be easy.
                    )
                Cue()
                    .actor("producer")
                    .responses("Worldc4m103") // We just need to grab some diesel.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b09") // You wanna hear a prediction?
                    .followups(
                        Followup()
                            .concept("GamblerPredictionResponse")
                            .target("all")
                    )
            )
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("coach")
            )
            .cues(
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m101") // This my friends, is a milk run.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m102") // A cake walk
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m103") // A walk in the park.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m104") // A walk in the sun.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m105") // Piece of cake.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m106") // All we need to do is get some diesel and get back on that boat.
                Cue()
                    .actor("coach")
                    .responses("Worldc4m103") // Don’t jinx us nick.
            )
    );

Concept()
    .name("GamblerPredictionResponse")
    .publishCues(
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler")
            )
            .responses(
                "No07"
                "No12"
            )
            .followups("gamblerPredictionContinue")
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler")
            )
            .responses(
                "No01"
                "No09"
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("gambler")
            )
            .responses(
                "No01"
                "No11"
            )
    );

Concept()
    .name("GamblerPredictionContinue")
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                // There’s not gonna be any gas, watch.
                "Worldc4m1b10"
                // Alright fine.
                "Worldc4m1b08"
            )
    );

Concept()
    .name("InBurgerTank")
    .remarkable(256)
    .publishCues(
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
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
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .cues(
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m117") // This is the best goddamn burger tank I’ve ever visited.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m118") // I hope no one minds us taking these guns.
            )
    );

Concept()
    .name("OutOfGas")
    .remarkable(712)
    .criterias(
        criteriaNotSaid("ThroughHere")
    )
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                // No gas, terrific, this is just great.
                "Worldc4m1b12"
                // No gas, see? What a say.
                "Worldc4m1b13"
            )
            .followups("GasPath")
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                Response()
                    .scene("Worldc4m104") // Empty. Gotta be another station.
                    .followups("GasPath")
                Response()
                    .scene("Worldc4m1b04") // Out of gas.
                    .followups("OutOfGasGamblerReact")
                Response()
                    .scene("Worldc4m1b03") // Next gas 2 miles, well shit
                    .followups("OutOfGasMarathon")
            ) 
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                Response()
                    .scene("Worldc4m1b08") // Next gas, two miles, looks like Virgil is going to be waiting a bit longer than he thought.
                    .followups(
                        Followup()
                            .concept("GasPath")
                            .target("mechanic")
                    )
                Response()
                    .scene("Worldc4m1b09") // Next gas, two miles, I hope Virgil likes waiting because it looks like we’re going for a walk.
                    .followups(
                        Followup()
                            .concept("GasPath")
                            .target("mechanic")
                    )
                Response()
                    .scene("Worldc4m1b10") // Out of gas… shit.
                    .followups("OutOfGasGamblerReact")
            )
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .cues(
                Cue()
                    .actor("mechanic")
                    .responses("Worldc4m1b07") // Out of gas.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m122") // I’m out of gas, you’re out of gas, they’re out of gas!
                    .followups("OutOfGasComplain")
            )
    );

Concept()
    .name("OutOfGasGamblerReact")
    .publishCues(
        Cue()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .actor("gambler")
            .responses(
                "Worldc4m120" // Out of gas!?
                "OutOfGasComplain" // Of course they’re out of gas.
            )
            .followups("OutOfGasComplain")
    );

Concept()
    .name("OutOfGasMarathon")
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(         
                "Worldc4m1b11" // Looks like our milk-run just turned into a marathon.
                "Worldc4m123" // There goes the milk run!
            )
            .followups("OutOfGasComplain")
    );

Concept()
    .name("OutOfGasComplain")
    .publishCues(
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses("Worldc4m1b13") // All right, quit whinin'. We just gotta hike to this Duke-atel diesel.
            .followups("DucatelDieselResponse")
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses("Worldc4m1b10") // No use whinin' about it. Let's get movin'.
            .followups("GasPath")
    );

Concept()
    .name("GasPath")
    .publishCues(
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                Response()
                    .scene("Worldc4m1b11") // Let's head to this Ducatel diesel.
                    .followups("DucatelDieselResponse")
                Response()
                    .scene("Worldc4m113") // Let's head to the sugar mill.
                    .followups("SugarMillResponse")
            )
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any") // Looks like we're gonna have to walk to this Ducatel place.
            )
            .responses("Worldc4m1b08")
            .followups("DucatelDieselResponse")
    );

Concept()
    .name("DucatelDieselResponse")
    .publishCues(
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .cues(
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m1b14") // What makes you think they still have gas?
                Cue()
                    .actor("coach")
                    .responses("Worldc4m1b12") // Because if they don’t, we’re going to be stuck here forever Nick.
            )
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .cues(
                Cue()
                    .actor("producer")
                    .responses(
                        "Worldc4m109" // It doesn’t look far.
                        "Worldc4m110" // Doesn’t look far at all.
                    )
                Cue()
                    .actor("producer")
                    .responses(                 
                        "Worldc4m111" // Let’s hurry up and do this before the storm hits
                        "Worldc4m108" //  Let’s get this done before the storm.
                    )
            )
    );
    
Concept()
    .name("SugarMillResponse")
    .publishCues(
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .cues(
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m124") // They’ve got diesel on the sugar mill?
                Cue()
                    .actor("producer")
                    .responses("Worldc4m107") // *kissey* C’mon boy we need to get to the old sugar mill.
                    .followups("SugarMillResponseEnd")
            )
        Sequence()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .cues(
                Cue()
                    .actor("producer")
                    .responses(                   
                        "Worldc4m105" // They have diesel at the old sugar mill?
                        "Worldc4m106" // The old sugar mill? *smirk* Are you kidding me?
                    )
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m126") // If we’re going, let’s hurry.
                Cue()
                    .actor("gambler")
                    .responses("Worldc4m127") // Wanna beat out this storm.
            )
    );

Concept()
    .name("SugarMillResponseEnd")
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                // Screw it, we need the diesel and we’ve got guns, let’s go get it.
                "Worldc4m125"
                // Let’s just get this done and get back.
                "Worldc4m1b17"
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses("Worldc4m1b14")
    );

Concept()
    .name("ThroughHere")
    .record()
    .remarkable(412)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldMisc03" // Right through here.
                "WorldMisc07" // Right through here.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional17" // Let's go through here!
                "MiscDirectional18" // Let's go through there!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional11" // Let's go through here!
                "MiscDirectional12" // Let's go through here!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional11" // Let's go through here!
                "MiscDirectional12" // Let's go through here!
            )
    );

Concept()
    .name("OverFence")
    .remarkable(228)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional22" // Over the fence!
                "MiscDirectional23" // Over that fence!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional27" // Over this fence!
                "MiscDirectional28" // Over this fence!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional22" // Over this fence!
                "MiscDirectional23" // Over this fence!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional21" // Over this fence!
                "MiscDirectional22" // Over this fence!
            )
    );

Concept()
    .name("UpLadder")
    .remarkable(228)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional18" // Up that ladder!
                "MiscDirectional19" // Up this ladder!
                "WorldMisc32" // Get up that ladder!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional23" // Up that ladder!
                "MiscDirectional24" // Up this ladder!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional17" // Up that ladder!
                "MiscDirectional18" // Up this ladder!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional17" // Up that ladder!
                "MiscDirectional18" // Up this ladder!
            )
    );

Concept()
    .name("LandmarksComment")
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses("Worldc4m1b16") // Hey watch out for landmarks, maybe coming through here in a hurry on the way back.
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b19" // Try to remember where the ammo dumps are at, we might need some on the way back.
                "Worldc4m1b18" // Alright, keep your eyes open for landmarks, we’re gonna have to come back through here.
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b22" // Look for landmarks, it might be dark on our way back.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b09" // We’re going to be coming back through here, so keep an eye out for the landmark.
            )
    );

Concept()
    .name("ToPlayground")
    .remarkable(820)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b17" // Through this playground.
                "Worldc4m1b18" // Hey through that playground
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b22" // Through this playground.
                "Worldc4m1b23" // Through that playground!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b25" // Through this playground.
                "Worldc4m1b26" // Through that playground.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b10" // Through this playground.
                "Worldc4m1b11" // Through that playground.
            )
    );

Concept()
    .name("ThroughDoor")
    .remarkable(228)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional13" // Through this door!
                "MiscDirectional14" // Through that door!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional19" // Through this door!
                "MiscDirectional20" // Through that door!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional13" // Through this door!
                "MiscDirectional14" // Through that door!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional13" // Through this door!
                "MiscDirectional14" // Through that door!
            )
    );

Concept()
    .name("DownStreet")
    .remarkable(492)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional03" // This way!
                "MiscDirectional06" // C'mon, this way!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m115" // Down this street.
                "Worldc4m116" // Keep going down the street.
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m132" // Down this street.
                "Worldc4m133" // Let’s go down this street.
                "Worldc4m136" // Let’s cut through this street.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC4M116" // Okay let’s try down this street.
            )
    );
    
Concept()
    .name("ThroughGarageSale")
    .remarkable(712)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b19" // We can cut through this garage sale.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b24" // Let’s cut through the garage sale.
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b27" // Let’s cut through the garage sale.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b12" // We can cut through this garage sale.
            )
    );

Concept()
    .name("ThroughGate")
    .remarkable(286)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional16" // Through that gate!
                "MiscDirectional17" // Right through that gate!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional22" // Through that gate!.
                "MiscDirectional44" // Through this gate!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional16" // Through that gate!
                "MiscDirectional20" // Through this gate!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional16" // Through that gate!
                "MiscDirectional38" // Through this gate!
            )
    );

Concept()
    .name("CheckRooms")
    .remarkable(224)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC1M1B87" // Search these rooms, y'all. Might be something we can use.
                "WorldC1M1B119" // Search these rooms, y'all. Might be some useful shit in some of em.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC1M1B84" // Search these rooms. Might be something we can use.
                "WorldC2M1B10" // Check the rooms. Might be somethin' useful.
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC1M1B35" // Search these rooms. Might be something we can use.
                "WorldC2M1B14" // We better search these rooms.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC2M1B22" // Don't forget to search the rooms.
                "WorldGenericproducer41" // Search those rooms. Might be something we can use.
            )
    );

Concept()
    .name("ThroughWindow")
    .remarkable(224)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional07" // Hey, through this window!
                "MiscDirectional08" // Through that window!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional13" // Through this window!
                "MiscDirectional14" // Through that window!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional07" // Through this window!
                "MiscDirectional08" // Through that window!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional07" // Through this window!
                "MiscDirectional08" // Through that window!
            )
    );

Concept()
    .name("DownHere")
    .remarkable(224)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional30" // We can get down here!
                "MiscDirectional31" // We can get down there!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional34" // We can get down here!
                "MiscDirectional35" // We can get down there!!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional29" // We can get down here!
                "MiscDirectional30" // We can get down there!
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional28" // We can get down here!
                "MiscDirectional29" // We can get down there!
            )
    );

Concept()
    .name("SugarMillSeen")
    .remarkable(370)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC4M1B27" // There's the sugar mill.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m116" // There’s the mill.
                "WorldC4M1B28" // There's the sugar mill.
            )
        Cue()
            .actor("gambler")
            .promptResponsesOnce()
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b31" // There’s the sugar mill.
                "Worldc4m130" // I’m guessing that the smoke stack is the sugar mill.
                "Worldc4m131" // Let’s head towards the smoke stack.
                "Worldc4m139" // That better be that god damn sugar mill.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b16" // There’s the sugar mill.
                "Worldc4m117" // We can get to the sugar mill through here.
            )
    );

Concept()
    .name("WreckComment")
    .remarkable(224)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b20" // Dam, that was quite a wreck.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b25" // That’s a nasty dam wreck.
            )
            .followups("WreckCommentResponse")
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b28" // Now that is a nasty wreck.
            )
            .followups("WreckCommentResponse")
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b13" // Now that is a nasty wreck.
            )
            .followups("WreckCommentResponse")
    );

Concept()
    .name("WreckCommentResponse")
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b21" // Hell I’ve walked away from a lot worse than that.
                "Worldc4m1b22" // Yeah, ass end of those things get real squirrelly in the rain.
            )
    );

Concept()
    .name("SaferoomSeen")
    .remarkable(684)
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional32" // There's a safe room up here!
                "MiscDirectional33" // Hey, there's a safe room right up there!
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional36" // There's a safe room up here!
                "MiscDirectional37" // There's a safe room up there!
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional43" // There's a safe room up here!
                "MiscDirectional44" // There's a safe room up there
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "MiscDirectional30" // There's a safe room up here!
                "MiscDirectional31" // There's a safe room up there!
            )
    );

Concept()
    .name("StormStarting")
    .triggerOnce()
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b18" // The rain’s getting worse.
                "Worldc4m1b19" // It’s really starting to come down.
                "Worldc4m1b21" // We need to move faster, I don’t wanna get trapped out here in a storm.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b16" // Alright let’s hussle people, storm’s coming quick around here.
                "Worldc4m112" // Storm’s coming up fast, but we should make it.
            )
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "WorldC4M1B15" // Hey can we make an effort to move fast here fore we all drown'd?
                "WorldC4M1B12" // Man, it is really startin' to pour.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b06" // Oh shoot, I do not want to get trapped out here in a storm.
            )
    );

Concept()
    .name("RainStarting")
    .triggerOnce()
    .publishCues(
        Cue()
            .actor("mechanic")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b11" // Is it raining? Nevermind, it is.
                "Worldc4m1b13" // Ah, what the hell, it’s raining.
            )
        Cue()
            .actor("coach")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b15" // It’s starting to rain.
                "Worldc4m1b17" // Ah hell, looks like a bad storm is coming.
            )
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m142" // It’s starting to rain.
                "Worldc4m143" // Shit, it’s starting to rain.
                "Worldc4m1b20" // Shit, it looks like it’s really going to storm.
            )
        Cue()
            .actor("producer")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b08" // And on top of everything else, it’s raining.
                "Worldc4m1b07" // Oh-oh, it’s raining.
            )
    );

Concept()
    .name("BoatComment")
    .remarkable(186)
    .triggerOnce()
    .publishCues(
        Cue()
            .actor("gambler")
            .criterias(
                criteriaNotInDanger()
                criteriaAliveAndNear("any")
            )
            .responses(
                "Worldc4m1b23" // What does everyone around here have a boat?
                "Worldc4m1b24" // If this rain keeps up we can sail this thing right to virgil.
            )
    );

class ResponseThen {

	thenList = null;
	followup = null;

	constructor(_thenList) {
		thenList = _thenList;
		followup = {
			delay = 0.0,
			func = Execute.bindenv(this)
		}
	}

	function Execute(speaker, query) {
		if (thenList.len() == 0) return;

		local then = WCScript.getRandomItem(thenList);
		local target = WCScript.getRandomItem(then.target);
		
		if (target == "All") {
			local expressers = ::rr_GetResponseTargets();
			foreach (name, recipient in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, recipient);
			}
		} else if (target == "Any") {
			EntFire("info_director", "FireConceptToAny", then.concept, then.delay);
		} else if (target == "Self") {
			DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, speaker);
		}
		else if (target == "Subject") {
			local expressers = ::rr_GetResponseTargets();
			if (query.subject in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, expressers[query.subject]);
			}	
		} else if (target == "From") {
			local expressers = ::rr_GetResponseTargets();
			if (query.from in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, expressers[query.from]);
			}
		} else if (target == "Orator") {
			EntFire("func_orator", "SpeakResponseConcept", then.concept, 0);
		} else {	
			local expressers = ::rr_GetResponseTargets();
			if (target in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, expressers[target]);
			} else {
				printl("ResponseThen::executes() couldn't find target: " + target);
			}
		}
	}
}

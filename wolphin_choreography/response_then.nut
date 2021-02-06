/** Fixes reference issues. */
local getRandomItem = randomItem;

class ResponseThen {

	func = null;
	delay = 0.0;
	followups = null;

	constructor(_followups) {
		followups = _followups;
		func = executes.bindenv(this);
	}

	function executes(speaker, query) {
		local followup = getRandomItem(followups);
		local target = getRandomItem(followup.target);
		
		if (target == "All") {
			local expressers = ::rr_GetResponseTargets()
			foreach (name, recipient in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", followup.concept, followup.delay, null, recipient);
			}
		} else if (target == "Any") {
			EntFire("info_director", "FireConceptToAny", followup.concept, followup.delay);
		} else if (target == "Self") {
			DoEntFire("!self", "SpeakResponseConcept", followup.concept, followup.delay, null, speaker);
		}
		else if (target == "Subject") {
			local expressers = ::rr_GetResponseTargets()
			if (query.subject in expressers) {
                DoEntFire("!self", "SpeakResponseConcept", followup.concept, followup.delay, null, expressers[query.subject]);
            }	
		} else if (target == "From") {
			local expressers = ::rr_GetResponseTargets();
			if (query.from in expressers) {
                DoEntFire("!self", "SpeakResponseConcept", followup.concept, followup.delay, null, expressers[query.from]);
            }
		} else if (target == "Orator") {
			EntFire("func_orator", "SpeakResponseConcept", followup.concept, 0);
		} else {	
			local expressers = ::rr_GetResponseTargets()
			if (target in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", followup.concept, followup.delay, null, expressers[target]);
			} else {
				printl("ResponseThen::executes() couldn't find target: " + target);
			}
		}
    }
}

/** Fixes reference issues. */
local getRandomItem = randomItem;

class ResponseThen {

	func = null;
	target = null;
	concept = null;
	delay = null;

	constructor(_target, _concept, _delay) {
		target = _target;
		concept = _concept;
		delay = _delay;
		func = executes.bindenv(this);
	}
	
	function executes(speaker, query) 
	{
		local randomTarget = getRandomItem(target);
		
		if (randomTarget == "All") {
			local expressers = ::rr_GetResponseTargets()
			foreach (name, recipient in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", concept, delay, null, recipient);
			}
		} else if (randomTarget == "Any") {
			EntFire("info_director", "FireConceptToAny", concept, delay);
		} else if (randomTarget == "Self") {
			DoEntFire("!self", "SpeakResponseConcept", concept, delay, null, speaker);
		}
		else if (randomTarget == "Subject") {
			local expressers = ::rr_GetResponseTargets()
			if (query.subject in expressers) {
                DoEntFire("!self", "SpeakResponseConcept", concept, delay, null, expressers[query.subject]);
            }	
		} else if (randomTarget == "From") {
			local expressers = ::rr_GetResponseTargets();
			if (query.from in expressers) {
                DoEntFire("!self", "SpeakResponseConcept", concept, delay, null, expressers[query.from]);
            }
		} else if (randomTarget == "Orator") {
			EntFire("func_orator", "SpeakResponseConcept", concept, 0);
		} else {	
			local expressers = ::rr_GetResponseTargets()
			if (randomTarget in expressers) {
				DoEntFire("!self", "SpeakResponseConcept", concept, delay, null, expressers[randomTarget]);
			} else {
				printl("Wolphin Choreography Script warning: couldn't find randomTarget: " + randomTarget);
			}
		}
    }
}

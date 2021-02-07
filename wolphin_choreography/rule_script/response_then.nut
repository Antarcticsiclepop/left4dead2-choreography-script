class ResponseThen {

	thenlist = null;
	followup = null;

	constructor(_thenlist) {
		thenlist = _thenlist;
		followup = {
			delay = 0.0,
			func = Execute.bindenv(this)
		}
	}

	function GetExpresserTarget(value) {
		if (value.tolower() == "namvet")
			return "NamVet";
		else if (value.tolower() == "teengirl")
			return "TeenGirl";
		else {
			return value.slice(0,1).toupper() + value.slice(1);
		}
	}

	function GetOratorList() {
		local oratorlist = [];
		local entity = null;

		while((entity = Entities.FindByClassname(entity, "func_orator")) != null)
			oratorlist.append(entity.GetName());

		return oratorlist;
	}

	function Execute(speaker, query) {
		if (thenlist.len() == 0) return;

		local then = WCScript.getRandomItem(thenlist);
		local target = WCScript.getRandomItem(then.target);
		
		printl(printTable(query));

		switch (target.tolower()) {
			case "all":
				local expresserlist = ::rr_GetResponseTargets();
				local oratorlist = GetOratorList();
				foreach (name, recipient in expresserlist)
					DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, recipient);
				foreach (orator in oratorlist)
					EntFire(orator, "SpeakResponseConcept", then.concept, then.delay);
				break;
			case "self":
				DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, speaker);
				break;
			case "any":
				EntFire("info_director", "FireConceptToAny", then.concept, then.delay);
				break;
			case "subject":
				local expresserlist = ::rr_GetResponseTargets();
				if (query.subject in expresserlist)
					DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, expresserlist[query.subject]);
				break;
			case "from":
				local expresserlist = ::rr_GetResponseTargets();
				if (query.from in expresserlist)
					DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, expresserlist[query.from]);
				break;
			case "func_orator":
				EntFire("func_orator", "SpeakResponseConcept", then.concept, then.delay);
				break;
			default:
				local expresserlist = ::rr_GetResponseTargets();
				local expressertarget = GetExpresserTarget(target);
				local oratorlist = GetOratorList();

				local oratorIndex = null;

				if (expressertarget in expresserlist)
					DoEntFire("!self", "SpeakResponseConcept", then.concept, then.delay, null, expresserlist[expressertarget]);
				else if ((oratorIndex = oratorlist.find(target)) != null)
					EntFire(oratorlist[oratorIndex], "SpeakResponseConcept", then.concept, then.delay);
				else
					printl("ResponseThen::executes() couldn't find target: " + target);
				break;
		}
	}
}

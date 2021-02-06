/** Fixes reference issues. */
local getRandomItem = randomItem;

class ResponseRule {

	rulename = null;
	criteria = null;
	responses = null;
	group_params = null;
	next_response = 0;
	played_responses = null;

	constructor() {
		criteria = [];
		responses = [];
		played_responses = [];
	}

	function setRuleName(_rulename) {
		rulename = _rulename;
		return this;
	}

	function setCriteria(_criteria) {
		criteria = _criteria.map(g_rr.rr_ProcessCriterion.bindenv(g_rr));
		return this;
	}

	function setResponses(_responses) {
		local processedRules = [];
		foreach (index, response in _responses) {
			response.func <- PlayedResponse(index);
			local processedRule = g_rr.rr_ProcessResponse.bindenv(g_rr)(response);
			processedRule.rule = this;
			processedRules.append(processedRule);
		}

		responses = processedRules;
		played_responses = processedRules.map(@(value) false);
		return this;
	}

	function setGroupParams(_group_params) {
		group_params = g_rr.RGroupParams(_group_params);
		return this;
	}

	function PlayedResponse(index) {
		return (@ (speaker, query) played_responses[index] = true).bindenv(this);
	}

	function SelectResponse() {
		if (group_params.permitrepeats)  {
			return getRandomItem(responses);
		}

		if (played_responses.filter(@(index, value) !value).len() == 0) {
			if (group_params.norepeat) {
				Disable();
				return;
			}

			played_responses.apply(@(value) false);
		}

		local unplayed_responses = [];
		foreach (index, value in played_responses) {
			if (!value) {
				unplayed_responses.push(index);
			}
		}
		
		// printl(rulename + "::Unplayed responses " + unplayed_responses.reduce(@(acc, cur) acc + ", " + cur));

		if (group_params.sequential) {
			local index = next_response;
			next_response = (next_response + 1) % responses.len();
			return responses[index];
		} else {
			local index = getRandomItem(unplayed_responses);
			return responses[index];
		}
	}

	function Disable() {
		printl("TODO: rule " + rulename + " wants to disable itself.");
	}
}

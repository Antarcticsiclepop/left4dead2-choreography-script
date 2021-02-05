/** Fixes reference issues. */
local getRandomItem = randomItem;

class Rule {

	rulename = null;
	criteria = [];
	responses = [];
	group_params = null;
	next_response = 0;
	played_responses = [];

	function setRuleName(_rulename) {
		rulename = _rulename;
	}

	function setCriteria(_criteria) {
		criteria = _criteria;
	}

	function setResponses(_responses) {
		foreach (index, response in _responses) {
			response.func <- PlayedResponse(index);
		}

		responses = _responses.map(g_rr.rr_ProcessResponse.bindenv(g_rr));
		played_responses = _responses.map(@(value) false);
	}

	function setGroupParams(_group_params) {
		group_params = _group_params;
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

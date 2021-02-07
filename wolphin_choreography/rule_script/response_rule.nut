class ResponseRule {

	rulename = null;
	criteria = null;
	responses = null;
	params = null;

	next_response = 0;
	played_responses = null;

	constructor(_rulename, _criteria, _responses, _params) {
		rulename = _rulename;
		criteria = _criteria;
		responses = _responses;
		params = _params;
	}

	function PlayedResponse(index) {
		return (function (speaker, query) {
			played_responses[index] = true;

			if (params.matchOnce || params.promptResponsesOnce && played_responses.filter(@(index, value) !value).len() == 0) {
				Disable(speaker, query);
			}
		}).bindenv(this);
	}

	function SelectResponse() {
		if (played_responses == null) {
			played_responses = responses.map(@(value) false);
		}

		if (params.repeatableResponses)  {
			return WCScript.getRandomItem(responses);
		}

		if (played_responses.filter(@(index, value) !value).len() == 0) {
			played_responses.apply(@(value) false);
		}

		if (params.promptResponsesSequentially) {
			local index = next_response;
			next_response = (next_response + 1) % responses.len();
			return responses[index];
		}

		local unplayed_responses = [];
		foreach (index, value in played_responses) {
			if (!value) {
				unplayed_responses.push(index);
			}
		}

		local index = WCScript.getRandomItem(unplayed_responses);
		return responses[index];
	}

	function Disable(speaker, query) {
		speaker.SetContext("Match" + rulename, "1", -1);
	}
}

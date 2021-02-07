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

	function setResponses(_responses) {
		local processedRules = [];
		foreach (index, response in _responses) {
			response.func <- PlayedResponse(index);
			local processedRule = g_rr.rr_ProcessResponse.bindenv(g_rr)(response);
			processedRule.rule = this;
			processedRules.append(processedRule);
		}

		responses = processedRules;
	}

	function PlayedResponse(index) {
		return (function (speaker, query) {
			played_responses[index] = true;
			if (
				params.matchOnce
				|| params.promptResponsesOnce
				&& played_responses.filter(@(index, value) !value).len() == 0
			) {
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
		g_rr.rr_ApplyContext(speaker, query, { match = { context = "Match" + rulename, value = 1, duration = -1 } }, true, null);
	}
}

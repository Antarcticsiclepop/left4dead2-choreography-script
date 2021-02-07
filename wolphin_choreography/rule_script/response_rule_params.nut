class ResponseRuleParams {

    repeatableResponses = false;
    promptResponsesSequentially = false;
    promptResponsesOnce = false;
    matchOnce = false;

    constructor(
        _repeatableResponses = false,
        _promptResponsesSequentially = false,
        _promptResponsesOnce = false,
        _matchOnce = false
    ) {
        repeatableResponses = _repeatableResponses;
        promptResponsesSequentially = _promptResponsesSequentially;
        promptResponsesOnce = _promptResponsesOnce;
        matchOnce = _matchOnce;
    }
}

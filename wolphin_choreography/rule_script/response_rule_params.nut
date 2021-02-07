class ResponseRuleParams {

    repeatableResponses = false;
    promptResponsesSequentially = false;
    promptResponsesOnce = false;
    matchOnce = false;

    constructor(
        _repeatableResponses,
        _promptResponsesSequentially,
        _promptResponsesOnce,
        _matchOnce
    ) {
        repeatableResponses = _repeatableResponses;
        promptResponsesSequentially = _promptResponsesSequentially;
        promptResponsesOnce = _promptResponsesOnce;
        matchOnce = _matchOnce;
    }
}

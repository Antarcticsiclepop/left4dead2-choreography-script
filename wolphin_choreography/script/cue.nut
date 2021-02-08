class Cue extends CriteriaBase {

    static _className = "Cue";

    _actor = null;
    _responses = null;
    _followups = null;
    _callback = null;

    _repeatableResponses = false;
    _promptResponsesSequentially = false;
    _promptResponsesOnce = false;
    _matchOnce = false;

    constructor() {
        base.constructor();
        _responses = [];
        _followups = [];
    }

    function actor(...) {
        _functionName = "actor";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _actor = vargv[0];
        return this;
    }

    function responses(...) {
        _functionName = "responses";

        if (vargv.len() == 1 && type (vargv[0]) == "array") {
            _responses = vargv[0];
        } else {
            _responses = vargv;
        }

        _validateArrayType(_responses, "string", WCScript.Response, "null");

        return this;
    }

    function callback(...) {
        _functionName = "callback";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "function");

        _callback = vargv[0];
        return this;
    }

    function followups(...) {
        _functionName = "followups";
        _validateArrayType(vargv, "string", WCScript.Followup);

        _followups = vargv;
        return this;
    }

    function repeatableResponses(...) {
        _functionName = "repeatableResponses";
        _validateNoParameters(vargv);

        _repeatableResponses = true;
        return this;
    }

    function promptResponsesSequentially(...) {
        _functionName = "promptResponsesSequentially";
        _validateNoParameters(vargv);

        _promptResponsesSequentially = true;
        return this;
    }

    function promptResponsesOnce(...) {
        _functionName = "promptResponsesOnce";
        _validateNoParameters(vargv);

        _promptResponsesOnce = true;
        return this;
    }

    function matchOnce(...) {
        _functionName = "promptResponsesOnce";
        _validateNoParameters(vargv);

        _matchOnce = true;
        return this;
    }
}

class Sequence extends CriteriaBase {

    _className = "Sequence";
    _cues = null;

    constructor() {
        base.constructor();
        _cues = [];
    }

    function cues(...) {
        _functionName = "cues";

        if (vargv.len() == 1 && type (vargv[0]) == "array") {
            _cues = vargv[0]
        } else {
            _cues = vargv;
        }

        _validateArrayType(_cues, WCScript.Cue, WCScript.Delay);

        return this;
    }
}

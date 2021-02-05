class Cue extends CriteriaBase {

    _className = "Cue";
    _orator = null;
    _responses = [];
    _followup = null;

    _repeatableResponses = false;
    _promptResponsesSequentially = false;
    _promptResponsesOnce = false;

    function orator(...) {
        _functionName = "orator";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _orator = vargv[0];
        return this;
    }

    function responses(...) {
        _functionName = "responses";

        if (vargv.len() == 1 && type (vargv[0]) == "array") {
            _responses = vargv[0];
        } else {
            _responses = vargv;
        }

        _validateArrayType(_responses, "string", "Response");

        return this;
    }


    function followup(...) {
        _functionName = "followup";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string", "Followup");

        _followup = vargv[0];
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
        _repeatableResponses = true;
        return this;
    }

    function promptResponsesOnce(...) {
        _functionName = "promptResponsesOnce";
        _validateNoParameters(vargv);

        _promptResponsesOnce = true;
        return this;
    }
}

class Sequence extends CriteriaBase {

    _className = "Sequence";
    _cues = [];

    function cues(...) {
        _functionName = "cues";

        if (vargv.len() == 1 && type (vargv[0]) == "array") {
            _cues = vargv[0]
        } else {
            _cues = vargv;
        }

        _validateArrayType(_cues, "Cue", "Delay");

        return this;
    }
}

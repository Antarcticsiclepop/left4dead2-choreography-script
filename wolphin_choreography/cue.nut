class Cue extends CriteriaBase {

    _className = "Cue";
    _orator = null;
    _responses = [];
    _followup = null;

    _repeatableResponse = false;
    _promptResponseSequentially = false;
    _promptResponseOnce = false;

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

    function repeatableResponse(...) {
        _functionName = "repeatableResponse";
        _validateNoParameters(vargv);

        _repeatableResponse = true;
        return this;
    }

    function promptResponseSequentially(...) {
        _functionName = "promptResponseSequentially";
        _validateNoParameters(vargv);

        _promptResponseSequentially = true;
        _repeatableResponse = true;
        return this;
    }

    function promptResponseOnce(...) {
        _functionName = "promptResponseOnce";
        _validateNoParameters(vargv);

        _promptResponseOnce = true;
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

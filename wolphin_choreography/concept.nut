class Concept extends ParserBase {

    _className = "Concept";
    _name = null;
    _randomize = false;
    _triggerOnce = false;
    _cues = null;
    _remarkable = null;
    _record = false;

    function remarkable(...) {
        _functionName = "remarkable";
        _validateParameterLength(vargv, 2);
        _validateArrayType(vargv, "integer");
        _validateRange(vargv, 0, 1);

        _remarkable = vargv;
        return this;
    }

    function randomize(...) {
        _functionName = "randomize";
        _validateNoParameters(vargv);

        _randomize = true;
        return this;
    }

    function triggerOnce(...) {
        _functionName = "triggerOnce";
        _validateNoParameters(vargv);

        _triggerOnce = true;
        return this;
    }

    function record(...) {
        _functionName = "record";
        _validateNoParameters(vargv);

        _record = true;
        return this;
    }

    function name(...) {
        _functionName = "name";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _name = vargv[0];
        return this;
    }

    function publishCues(...) {
        _cues = vargv;
        _processConcept();
    }
}

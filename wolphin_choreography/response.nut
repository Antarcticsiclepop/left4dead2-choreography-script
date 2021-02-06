class Response extends Validateable {

    _className = "Response";
    _scene = null;
    _followups = null;
    _callback = null;

    constructor() {
        base.constructor()
        _followups = [];
    }

    function scene(...) {
        _functionName = "scene";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _scene = vargv[0];
        return this;
    }

    function followups(...) {
        _functionName = "followups";
        _validateArrayType(vargv, "string", "Followup");

        _followups = vargv;
        return this;
    }

    function callback(...) {
        _functionName = "callback";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "function");

        _callback = vargv[0];
        return this;
    }
}

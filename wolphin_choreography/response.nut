class Response extends Validateable {

    _className = "Response";
    _scene = null;
    _followup = null;

    function scene(...) {
        _functionName = "scene";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _scene = vargv[0];
        return this;
    }

    function followup(...) {
        _functionName = "followup";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string", "Followup");

        _followup = vargv[0];
        return this;
    }
}

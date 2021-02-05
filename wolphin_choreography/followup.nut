class Followup extends Validateable {

    _className = "Followup";
    _concept = null;
    _target = null;
    _delay = null;

    function concept(...) {
        _functionName = "concept";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _concept = vargv[0];
        return this;
    }

    function target(...) {
        _functionName = "target";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "string");
        _validateString(vargv[0]);

        _target = vargv[0];
        return this;
    }

    function delay(...) {
        _functionName = "delay";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "integer", "float");

        _delay = vargv[0];
        return this;
    }
}

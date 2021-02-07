
class Followup extends Validateable {

    static _className = "Followup";

    _concept = null;
    _target = null;
    _delay = 0.0;

    constructor() {
        base.constructor()
        _target = ["Any"];
    }

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

        if (vargv[0].len() == 0) {
            return this;
        }

        _validateArrayType(vargv, "string");

        _target = vargv;
        return this;
    }

    function delay(...) {
        _functionName = "delay";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "integer", "float");

        _delay = vargv[0].tofloat();
        return this;
    }
}

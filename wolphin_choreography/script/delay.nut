class Delay extends Validateable {
    
    static _className = "Delay";

    _delay = null;

    constructor(...) {
        base.constructor();
        _functionName = "constructor";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "integer", "float");

        _delay = vargv[0];
    }
}

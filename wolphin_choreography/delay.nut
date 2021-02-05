class Delay extends Validateable {
    
    _className = "Delay";
    _delay = null;

    constructor(...) {
        _functionName = "constructor";
        _validateParameterLength(vargv, 1);
        _validateType(vargv[0], "integer", "float");

        _delay = vargv[0];
    }
}


class Followup extends Validateable {

    _className = "Followup";
    _concept = null;
    _target = ["Any"];
    _delay = 0.0;

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

        _target = vargv.map(function (value) {
            if (value.tolower() == "namvet")
                return "NamVet";
            else if (value.tolower() == "teengirl")
                return "TeenGirl";
            else {
                return value.slice(0,1).toupper() + value.slice(1);
            }
        });

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

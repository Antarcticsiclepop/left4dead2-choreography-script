class CriteriaBase extends Validateable {

    _criterias = null;

    constructor() {
        base.constructor();
        _criterias = [];
    }

    function criterias(...) {
        _functionName = "criterias";

        local criterias = [];

        foreach (criteria in vargv) {
            _validateType(criteria, "array");

            if (criteria.len() > 0 && type (criteria[0]) == "array") {
                foreach (subcriteria in criteria) {
                    _validateCriteria(subcriteria);

                    criterias.append(subcriteria);
                }
            } else {
                _validateCriteria(criteria);

                criterias.append(criteria);
            }
        }

        _criterias = criterias;
        return this;
    }

    function _throwInvalidCriteria(criteria) {
        throw _getReference() + " found an invalid criteria: [" + _printArrayItems(criteria) + "]";
    }

    function _validateCriteria(criteria) {
        switch(criteria.len()) {
            case 0:
                throw _getReference() + " found an empty criteria: []";
            case 1:
                try {
                    _validateType(criteria[0], "string", "function");
                } catch (message) {
                    _throwInvalidCriteria(criteria);
                }

                break;
            case 2:
                try {
                    _validateType(criteria[0], "string");
                    _validateType(criteria[1], "string", "integer", "float", "function");
                } catch (message) {
                    _throwInvalidCriteria(criteria);
                }

                break;
            case 3:
                try {
                    _validateType(criteria[0], "string");
                    _validateType(criteria[1], "string", "integer", "float");
                    _validateType(criteria[2], "string", "integer", "float");
                } catch (message) {
                    _throwInvalidCriteria(criteria);
                }

                break;
            default:
                throw _getReference() + " found a criteria with more than 3 items: [" + _printArrayItems(criteria) + "]";
        }
    }
}

class Validateable {

    _functionName = null;

    constructor() { }

    function _getReference() {
        return _className + "::" + _functionName + "()";
    }

    function _validateParameterLength(list, maxLength) {
        if (list.len() == 0 || list.len() > maxLength) {
            throw _getReference() + " found with wrong number (" + list.len() + ") of parameters: (" + list.reduce(@(acc, cur) acc + ", " + cur) + ")";
        }
    }

    function _validateString(object) {
        if (strip(object).len() == 0) {
            throw _getReference() + " found invalid string: '" + object + "'";
        }
    }

    function _validateArrayType(list, ...) {
        foreach (item in list) {
            local args = [this, item];
            args.extend(vargv);
            _validateType.acall(args);
        }
    }

    function _validateType(object, ...) {
        foreach (objectType in vargv) {
            if (type (object) == objectType || "_className" in object && object._className == objectType) {
                return;
            }
        }

        local objectType = "_className" in object ? object._className : type (object);
        throw _getReference() + " has invalid value/data type: (" + objectType + ") " + object;
    }

    function _validateRange(list, minIndex, maxIndex) {
        if (list.len() > maxIndex) {
            if (list[maxIndex] < list[minIndex]) {
                throw _getReference() + " has invalid range: MIN(" + list[minIndex] + ") MAX(" + list[maxIndex] + ")";
            }
        }
    }

    function _validateNoParameters(list) {
        if (list.len() > 0) {
            throw _getReference() + " found with wrong number (" + list.len() + ") of parameters: " + _printArrayItems(list);
        }
    }

    function _printArrayItems(list) {
        return list.reduce(@(acc, cur) acc + ", " + cur);
    }
}

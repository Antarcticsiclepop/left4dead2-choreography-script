class CriterionBase {
    key = null;
    constructor(_key) { key = _key }
}

class Criterion extends CriterionBase {

	bottom = null;
	top = null;

    constructor(_key, _bottom, _top) {
        base.constructor(_key);
        bottom =_bottom;
        top = _top;
    }
}

class CriterionFunc extends CriterionBase {

	key = null;
	func = null;

    constructor(_key, _func) {
        base.constructor(_key);
        func = _func;
    }
}

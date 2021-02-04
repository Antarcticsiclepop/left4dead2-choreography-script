class Followup {

    _concept = null;
    _target = null;
    _delay = null;

    function concept(concept) {
        _concept = concept;
        return this;
    }

    function target(target) {
        _target = target;
        return this;
    }

    function delay(delay) {
        _delay = delay;
        return this;
    }
}

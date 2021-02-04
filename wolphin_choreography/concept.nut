class Concept extends Parser {

    _name = null;
    _randomize = false;
    _triggerOnce = false;
    _cues = null;
    _remarkable = null;
    _record = false;
    _criterias = null;

    function remarkable(...) {
        _remarkable = vargv;
        return this;
    }

    function randomize(randomize) {
        _randomize = randomize;
        return this;
    }

    function triggerOnce() {
        _triggerOnce = true;
        return this;
    }

    function record() {
        _record = true;
        return this;
    }

    function criterias(...) {
        local criterias = [];
        foreach (criteria in vargv) {
            if (type (criteria[0]) == "array") {
                foreach (subcriteria in criteria) {
                    criterias.append(subcriteria);
                }
            } else {
                criterias.append(criteria);
            }
        }

        _criterias = criterias;
        return this;
    }

    function name(concept) {
        _name = concept;
        return this;
    }

    function publishCues(...) {
        _cues = vargv;
        processConcept();
    }
}

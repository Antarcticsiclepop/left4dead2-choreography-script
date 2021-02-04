class CueBase {

    _criterias = [];

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
}


class Cue extends CueBase {

    _orator = null;
    _responses = [];
    _followup = null;

    function orator(orator) {
        _orator = orator;
        return this;
    }

    function responses(...) {
        if (type (vargv[0]) == "array") {
            _responses = vargv[0]
        } else {
            _responses = vargv;
        }
        return this;
    }


    function followup(followup) {
        _followup = followup;
        return this;
    }
}

class Sequence extends CueBase {

    _cues = [];

    function cues(...) {
        if (type (vargv[0]) == "array") {
            _cues = vargv[0]
        } else {
            _cues = vargv;
        }
        return this;
    }
}

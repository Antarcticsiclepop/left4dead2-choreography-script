function convertToCriterion(criteria) {
    switch (criteria.len()) {
        case 1:
            if (typeof(criteria[0]) == "function") {
                return WCScript.CriterionFunc(null, criteria[0]);
            } else {
                return WCScript.Criterion(criteria[0], null, null);
            }
        case 2:
            if (typeof(criteria[1]) == "function") {
                return WCScript.CriterionFunc(criteria[0], criteria[1]);
            } else {
                return WCScript.Criterion(criteria[0], criteria[1], criteria[1]);
            }
        default:
            return WCScript.Criterion(criteria[0], criteria[1], criteria[2]);
    }
}

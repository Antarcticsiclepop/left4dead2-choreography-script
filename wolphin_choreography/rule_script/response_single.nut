class ResponseSingle {

	kind = null;
	target = null;
	func = null;
	params = null;
	rule = null;
    cpp_visitor = null;
	callbacklist = null;

	constructor(_kind, _target, _rule, _callbacklist, _params) {
		kind = _kind;
		target = _target;
		rule = _rule;
		params = _params == null ? {} : _params;
		func = Execute.bindenv(this);
		callbacklist = _callbacklist;
	}

	function Execute(speaker, query) {
		foreach (callback in callbacklist) {
			if (callback != null) {
				callback(speaker, query);
			}
		}
	}
}

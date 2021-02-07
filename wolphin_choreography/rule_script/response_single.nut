class ResponseSingle {

	kind = null;
	target = null;
	func = null;
	params = null;
	rule = null;
    cpp_visitor = null;
	applycontext = null;
	callbacklist = null;

	constructor(_kind, _target, _rule, _applycontext, _callbacklist, _params) {
		kind = _kind;
		target = _target;
		rule = _rule;
		params = _params == null ? {} : _params;
		func = Execute.bindenv(this);
		applycontext = _applycontext;
		callbacklist = _callbacklist;
	}

	function Execute(speaker, query) {
		g_rr.rr_ApplyContext(speaker, query, applycontext, true, null);
		foreach (callback in callbacklist) {
			if (callback != null) {
				callback(speaker, query);
			}
		}
	}
}

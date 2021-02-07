class ResponseSingle {

	kind = null;
	target = null;
	func = null;
	params = null;
	rule = null;
    cpp_visitor = null;

	constructor(_kind, _target, _rule, _func, _params = {})
	{
		kind = _kind;
		target = _target;
		rule = _rule;
		params = _params == null ? {} : _params;
		func = _func;
	}
}

class Response {

    _scene = null;
    _followup = null;

    function scene(scene) {
        _scene = scene;
        return this;
    }

    function followup(followup) {
        _followup = followup;
        return this;
    }
}

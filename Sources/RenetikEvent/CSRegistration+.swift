extension CSRegistration {

    func pause() -> CSCloseable {
        isActive = false
        return Closeable { [unowned self] in resume() }
    }

    func pause(function: Func) {
        isActive = false
        function()
        isActive = true
    }

    @discardableResult
    func resume() -> Self {
        isActive = true
        return self
    }
}

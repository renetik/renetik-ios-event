public extension CSEvent where Type == Void {

    @discardableResult
    func fire() -> Self { fire(()); return self }

    @discardableResult
    @inlinable func listenOnce(function: @escaping Func) -> CSRegistration {
        listen(function: { listener, argument in
            listener.cancel()
            function()
        })
    }

    @discardableResult
    func listen(function: @escaping Func) -> CSRegistration {
        listeners.add(CSEventListener(event: self, function: { _, argument in
            function()
        }))
    }
}

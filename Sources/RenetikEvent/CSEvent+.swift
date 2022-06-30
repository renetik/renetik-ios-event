extension CSEvent {

    @discardableResult
    func listen(function: @escaping (CSRegistration, Type) -> Void) -> CSRegistration {
        var registration: CSRegistration? = nil
        registration = listen(function: { function(registration!, $0) })
        return registration!
    }

    @discardableResult
    func listen(function: @escaping (Type) -> Void) -> CSRegistration {
        listeners.add(CSEventListener(event: self, function: { _, argument in
            function(argument)
        }))
    }


    @discardableResult
    func listen(function: @escaping () -> Void) -> CSRegistration {
        listeners.add(CSEventListener(event: self, function: { _, argument in
            function()
        }))
    }

    @discardableResult
    func listenOnce(function: @escaping (Type) -> Void) -> CSRegistration {
        listen { registration, value in
            function(value)
            registration.cancel()
        }
    }

    @discardableResult
    func listenOnce(function: @escaping () -> Void) -> CSRegistration {
        listen { registration, value in
            function()
            registration.cancel()
        }
    }
}

public extension CSEvent where Type == Void {
    @discardableResult
    func fire() -> Self { fire(()); return self }
}

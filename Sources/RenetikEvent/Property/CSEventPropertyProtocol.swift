public protocol CSEventPropertyProtocol: CSProperty {
    @discardableResult
    func onChange(_ function: @escaping (T) -> Void) -> CSRegistration
}

extension CSEventPropertyProtocol {
    @discardableResult
    public func onChange(_ function: @escaping () -> Void) -> CSRegistration {
        onChange { _ in function() }
    }

    @discardableResult
    public func onChange(_ function: @escaping (CSRegistration, T) -> Void) -> CSRegistration {
        var registration: CSRegistration? = nil
        registration = onChange { function(registration!, $0) }
        return registration!
    }

    @discardableResult
    public func onChangeOnce(_ function: @escaping (T) -> Void) -> CSRegistration {
        onChange { registration, value in
            registration.cancel()
            function(value)
        }
    }

    @discardableResult
    public func onChangeOnce(_ function: @escaping () -> Void) -> CSRegistration {
        onChange { registration, _ in
            registration.cancel()
            function()
        }
    }
}

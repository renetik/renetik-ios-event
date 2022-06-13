public protocol CSEventOwner {
    var registrations: CSRegistrations { get }
}

public extension CSEventOwner {
    @discardableResult
    func register(_ registration: CSRegistration) -> CSRegistration {
        registration.also { registrations.add($0) }
    }

    @discardableResult
    func register(_ key: String, _ registration: CSRegistration) -> CSRegistration {
        registrations.add(key, registration)
        return registration
    }

    @discardableResult
    func cancel(_ registration: CSRegistration) -> CSRegistration {
        registration.also { registrations.cancel($0) }
    }

    @discardableResult
    func remove(_ registration: CSRegistration) -> CSRegistration {
        registration.also { registrations.remove($0) }
    }

    @discardableResult
    func register(_ registration: CSRegistration?) -> CSRegistration? {
        registration?.also { registrations.add($0) }
    }

    @discardableResult
    func cancel(_ registration: CSRegistration?) -> CSRegistration? {
        registration?.also { registrations.cancel($0) }
    }

    func cancel(_ registrations: CSRegistration?...) {
        registrations.forEach { cancel($0) }
    }

    func cancel(_ registrations: [CSRegistration]?) {
        registrations?.forEach { cancel($0) }
    }

    @discardableResult
    func remove(_ registration: CSRegistration?) -> CSRegistration? {
        registration?.also { registrations.remove($0) }
    }
}

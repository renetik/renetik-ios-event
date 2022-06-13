public class CSRegistrations {

    private var registrations = [String: CSRegistration]()
    private var active = true
    private let queue = DispatchQueue(label: "CSRegistrations.\(UUID().uuidString)")

    //@AnyThread
    func cancel() {
        queue.sync {
            registrations.forEach { $0.value.cancel() }
            registrations.clear()
        }
    }

    //@AnyThread
    @discardableResult
    func addAll(_ registrations: CSRegistration...) -> CSRegistrations {
        queue.sync {
            registrations.forEach { add($0) }
            return self
        }
    }


    //@AnyThread
    @discardableResult
    func add(_ registration: CSRegistration) -> CSRegistration {
        queue.sync {
            if !registration.isActive { return registration }
            registration.isActive = active
            registrations["\(CFAbsoluteTimeGetCurrent())"] = registration
            return registration
        }
    }


    //@AnyThread
    @discardableResult
    func add(_ key: String, _ registration: CSRegistration) -> CSRegistration {
        queue.sync {
            if !registration.isActive { return registration }
            registrations[key]?.cancel()
            registrations[key] = registration
            registration.isActive = active
            return registration
        }
    }

    //@AnyThread
    func cancel(_ registration: CSRegistration) {
        queue.sync {
            registration.cancel()
            remove(registration)
        }
    }

    //@AnyThread
    func remove(_ registration: CSRegistration) {
        queue.sync {
            registrations.removeIf { _, value in value == registration }
        }
    }

    //@AnyThread
    func setActive(_ active: Bool) {
        queue.sync {
            self.active = active
            for registration in registrations { registration.value.isActive = active }
        }
    }
}

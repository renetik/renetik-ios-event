public extension CSEventPropertyProtocol where T: CSAnyProtocol {
    var isSet: Bool {
        get { value.notNil }
    }
}

public extension CSEventPropertyProtocol where T == Bool {
    @discardableResult
    func toggle() -> Self { value = !value; return self }

    @discardableResult
    func setFalse() -> Self { value = false; return self }

    @discardableResult
    func setTrue() -> Self { value = true; return self }

    @discardableResult
    func onFalse(function: @escaping () -> Void) -> CSRegistration {
        onChange { if $0.isFalse { function() } }
    }

    @discardableResult
    func onTrue(function: @escaping () -> Void) -> CSRegistration {
        onChange { if $0.isTrue { function() } }
    }

    var isTrue: Bool {
        get { value }
        set { value = newValue }
    }

    var isFalse: Bool {
        get { !value }
        set { value = !newValue }
    }
}

public extension CSEventPropertyProtocol where T == String? {
    var string: T {
        get { value.asString }
        set { value = newValue }
    }

    func text(_ string: T) { value = string }

    func string(_ string: T) { value = string }

    func clear() { value = nil } // TODO: How to make this generic for any optional ?
}

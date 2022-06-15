open class CSEventPropertyImpl<T>: CSEventPropertyProtocol where T: Equatable {

    private let eventChange: CSEvent<T> = event()
    private var onApply: ((T) -> ())?
    private var _value: T

    public var value: T {
        get { _value }
        set { value(newValue, fireEvents: true) }
    }

    public init(value: T, onApply: ((T) -> ())? = nil) {
        _value = value
        self.onApply = onApply
    }

    @discardableResult
    public func value(_ newValue: T, fireEvents: Bool = true) -> Self {
        if _value == newValue { return self }
        _value = newValue
        if (fireEvents) {
            onApply?(newValue)
            eventChange.fire(newValue)
        }
        return self
    }

    @discardableResult
    public func onChange(_ function: @escaping ArgFunc<T>) -> CSRegistration {
        eventChange.listen { function($0) }
    }

    @discardableResult
    public func apply() -> Self {
        onApply?(value)
        eventChange.fire(value)
        return self
    }
}

// In android CSEventPropertyBase
open class CSEventProperty<T>: CSObject, CSEventPropertyProtocol where T: Equatable {
    private var onApply: ((T) -> ())?

    public init(onApply: ((T) -> ())? = nil) {
        self.onApply = onApply
    }

    public var value: T {
        get { fatalError("value has not been implemented") }
        set { }
    }

    private let eventChange: CSEvent<T> = event()

    @discardableResult
    public func onChange(_ function: @escaping ArgFunc<T>) -> CSRegistration {
        eventChange.listen { function($0) }
    }

    public var description: String { "\(super.description)+value:\(value)" }

    @discardableResult
    public func apply() -> Self { onValueChanged(value); return self }

    open func onValueChanged(_ newValue: T, fire: Boolean = true) {
        onApply?(value)
        if fire { eventChange.fire(newValue) }
    }
}

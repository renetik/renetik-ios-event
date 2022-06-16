open class CSEventProperty<T>: CSObject, CSEventPropertyProtocol where T: Equatable {

    var onApply: ((T) -> ())?
    let eventChange: CSEvent<T> = event()

    public init(onApply: ((T) -> ())? = nil) {
        self.onApply = onApply
    }

    public var value: T {
        get { fatalError("value has not been implemented") }
        set { }
    }

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

open class CSEventPropertyImpl<T>: CSEventProperty<T> where T: Equatable {

    private var _value: T

    public init(value: T, onApply: ((T) -> ())? = nil) {
        _value = value
        super.init(onApply: onApply)
    }

    public override var value: T {
        get { _value }
        set { value(newValue, fireEvents: true) }
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
}

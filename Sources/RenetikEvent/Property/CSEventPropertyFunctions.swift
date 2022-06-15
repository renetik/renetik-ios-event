public func property<T>(_ value: T, _ onApply: ((T) -> ())? = nil) -> CSEventPropertyImpl<T> {
    CSEventPropertyImpl(value: value, onApply: onApply)
}

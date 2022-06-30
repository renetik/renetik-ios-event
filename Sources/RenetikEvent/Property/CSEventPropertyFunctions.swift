public func property<T>(_ value: T, _ onApply: ((T) -> Void)? = nil) -> CSEventPropertyImpl<T> {
    CSEventPropertyImpl(value: value, onApply: onApply)
}
public func property<T>(_ value: T,
    _ onApply: @escaping () -> Void) -> CSEventPropertyImpl<T> {
    CSEventPropertyImpl(value: value, onApply: { _ in onApply() })
}


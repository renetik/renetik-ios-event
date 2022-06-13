public protocol CSEventPropertyProtocol: CSProperty {
    @discardableResult
    func onChange(_ function: @escaping (T) -> Void) -> CSRegistration
}

extension CSEventPropertyProtocol {
    @discardableResult
    public func onChange(_ function: @escaping Func) -> CSRegistration {
        self.onChange { _ in function() }
    }
}

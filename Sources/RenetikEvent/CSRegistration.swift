open class CSRegistration: CSObject {
    open var isActive = true

    open func cancel() { isActive = false }

    static func construct(onCancel: Func? = nil) -> CSRegistration {
        CSRegistrationImpl(onCancel)
    }
}

class CSRegistrationImpl: CSRegistration {
    let onCancel: Func?

    init(_ onCancel: Func? = nil) {
        self.onCancel = onCancel
    }
    override func cancel() {
        super.cancel()
        onCancel?()
    }
}

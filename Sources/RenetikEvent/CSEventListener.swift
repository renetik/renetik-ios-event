public class CSEventListener<Type>: CSRegistration {
    public typealias CSEventFunction = (CSEventListener<Type>, Type) -> Void

    private weak var event: CSEvent<Type>?
    private let function: CSEventFunction

    init(event: CSEvent<Type>, function: @escaping CSEventFunction) {
        self.event = event
        self.function = function
    }

    private var canceled = false

    public override func cancel() {
        if canceled { return }
        isActive = false
        event?.remove(listener: self)
        canceled = true
    }

    func fire(_ argument: Type) {
        if isActive { function(self, argument) }
    }
}

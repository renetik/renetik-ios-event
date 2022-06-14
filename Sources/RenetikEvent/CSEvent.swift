public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }

public func event() -> CSEvent<Void> { CSEvent<Void>() }

public class CSRegistration: CSObject {
    open var isActive = true

    open func cancel() { fatalError() }
}

public struct CSEventArgument<Type> {
    public let registration: CSEventListener<Type>
    public let argument: Type
}

public class CSEventListener<Type>: CSRegistration {

    public typealias CSEventFunction = (CSEventListener<Type>, Type) -> Void

    private unowned let event: CSEvent<Type>
    private let function: CSEventFunction

    fileprivate init(event: CSEvent<Type>, function: @escaping CSEventFunction) {
        self.event = event
        self.function = function
    }

    private var canceled = false

    override public func cancel() {
        if canceled { return }
        isActive = false
        event.remove(listener: self)
        canceled = true
    }

    fileprivate func fire(_ argument: Type) {
        if isActive { function(self, argument) }
    }
}

public class CSEvent<Type> {


    public init() { }

    private var listeners = [CSEventListener<Type>]()

    public func fire(_ argument: Type) {
        for listener in listeners { listener.fire(argument) }
    }

    @discardableResult
    public func listen(function: @escaping (Type) -> Void) -> CSRegistration {
        listeners.add(CSEventListener(event: self, function: { _, argument in
            function(argument)
        }))
    }

    @discardableResult
    public func listen(function: @escaping (CSEventListener<Type>, Type) -> Void) -> CSRegistration {
        listeners.add(CSEventListener(event: self, function: function))
    }

    @discardableResult
    @inlinable public func listenOnce(function: @escaping Func) -> CSRegistration {
        listenOnce { argument in function() }
    }

    @discardableResult
    @inlinable public func listenOnce(function: @escaping ArgFunc<Type>) -> CSRegistration {
        listen(function: { listener, argument in
            listener.cancel()
            function(argument)
        })
    }

    fileprivate func remove(listener: CSEventListener<Type>) {
        listeners.remove(all: listener)
    }

    @discardableResult
    public func clear() -> Self { listeners.clear(); return self }
}

public extension CSEvent where Type == Void {

    @discardableResult
    func fire() -> Self { fire(()); return self }

    @discardableResult
    @inlinable func listenOnce(function: @escaping Func) -> CSRegistration {
        listen(function: { listener, argument in
            listener.cancel()
            function()
        })
    }

    @discardableResult
    func listen(function: @escaping Func) -> CSRegistration {
        listeners.add(CSEventListener(event: self, function: { _, argument in
            function()
        }))
    }
}

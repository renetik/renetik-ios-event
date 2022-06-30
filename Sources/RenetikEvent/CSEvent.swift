public func event<Type>() -> CSEvent<Type> { CSEvent<Type>() }
public func event() -> CSEvent<Void> { CSEvent<Void>() }

public class CSEvent<Type> {

    public init() { }

    var listeners = [CSEventListener<Type>]()

    public func fire(_ argument: Type) {
        for listener in listeners { listener.fire(argument) }
    }

//    @discardableResult
//    public func listen(function: @escaping (Type) -> Void) -> CSRegistration {
//        listeners.add(CSEventListener(event: self, function: { _, argument in
//            function(argument)
//        }))
//    }

//    @discardableResult
//    public func listen(function: @escaping (CSEventListener<Type>, Type) -> Void) -> CSRegistration {
//        listeners.add(CSEventListener(event: self, function: function))
//    }
//
//    @discardableResult
//    @inlinable public func listenOnce(function: @escaping Func) -> CSRegistration {
//        listenOnce { argument in function() }
//    }
//
//    @discardableResult
//    @inlinable public func listenOnce(function: @escaping ArgFunc<Type>) -> CSRegistration {
//        listen(function: { listener, argument in
//            listener.cancel()
//            function(argument)
//        })
//    }

    func remove(listener: CSEventListener<Type>) { listeners.remove(all: listener) }

    @discardableResult
    public func clear() -> Self { listeners.clear(); return self }
}



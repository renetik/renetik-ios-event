import Foundation

public protocol CSHasDestroy: CSAnyProtocol {
    var eventDestroy: CSEvent<Void> { get }
}

public extension CSHasDestroy {
    func onDestroy() {}

    func onDestroy(listener: @escaping Func) -> CSRegistration {
        eventDestroy.listenOnce { _ in listener() }
    }
}

import Foundation

open class CSBase: CSObject, CSEventOwnerHasDestroy {
    public init(parent: CSHasDestroy? = nil) {
        super.init()
        parent?.also {
            register($0.eventDestroy.listenOnce { [unowned self] in onDestroy() })
        }
    }

    public var eventDestroy = event()
    public let registrations = CSRegistrations()
    private(set) var isDestroyed: Boolean = false

    public func onDestroy() {
        registrations.cancel()
        isDestroyed = true
        eventDestroy.fire().clear()
    }
}
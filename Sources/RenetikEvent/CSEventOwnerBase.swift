import Foundation

open class CSEventOwnerBase: CSObject, CSEventOwner {
    public let registrations = CSRegistrations()
    deinit {
        registrations.cancel()
    }
}

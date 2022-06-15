import Foundation

open class CSBase: CSObject, CSEventOwner {
    public let registrations = CSRegistrations()
    deinit {
        registrations.cancel()
    }
}

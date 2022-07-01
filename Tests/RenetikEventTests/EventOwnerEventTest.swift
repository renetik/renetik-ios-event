import XCTest
@testable import RenetikEvent

/**
 * Event unregister after owner niled
 */
final class EventOwnerEventTest: XCTestCase {

    func testUnregisteredAfterNiled() throws {
        var owner: CSEventOwner? = CSEventOwnerBase()
        let event = event()
        var count = 0
        owner!.register(event.listen { count += 1 })
        event.fire()
        event.fire()
        XCTAssertEqual(count, 2)
        owner = nil
        event.fire()
        XCTAssertEqual(count, 2)
    }
}

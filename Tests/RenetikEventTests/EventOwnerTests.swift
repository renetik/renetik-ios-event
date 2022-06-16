import XCTest
@testable import RenetikEvent

final class EventOwnerTests: XCTestCase {

    var owner: CSEventOwner? = CSEventOwnerBase()

    func testListen() throws {
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

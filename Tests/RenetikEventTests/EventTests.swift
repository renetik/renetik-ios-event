import XCTest
@testable import RenetikEvent

final class EventTests: XCTestCase {

    func testListen() throws {
        let event = event()
        var count = 0
        event.listen { count += 1 }
        event.fire()
        event.fire()
        XCTAssertEqual(count, 2)
    }

    func testArgEventListen() throws {
        let event: CSEvent<Int> = event()
        var count = 0
        event.listen { count += $0 }
        event.fire(2)
        event.fire(3)
        XCTAssertEqual(count, 5)
    }

    func testEventListeOnce() throws {
        let event = event()
        var count = 0
        event.listenOnce { count += 1 }
        event.fire()
        event.fire()
        XCTAssertEqual(count, 1)
    }

    func testEventCancel() throws {
        let event = event()
        var count = 0
        let registration = event.listen { count += 1 }
        event.fire()
        registration.cancel()
        event.fire()
        XCTAssertEqual(count, 1)
    }

    func testEventPause() throws {
        let event = event()
        var count = 0
        let registration = event.listen { count += 1 }
        registration.pause { event.fire() }
        event.fire()
        XCTAssertEqual(count, 1)
    }
}

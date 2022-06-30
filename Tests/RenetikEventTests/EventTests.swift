import XCTest
@testable import RenetikEvent

/**
 * Simple event use cases
 */
final class EventTests: XCTestCase {

    func testListen() throws {
        let event = event()
        var count = 0
        event.listen { count += 1 }
        event.fire()
        event.fire()
        XCTAssertEqual(count, 2)
    }

    func testArgListen() throws {
        let event: CSEvent<Int> = event()
        var count = 0
        event.listen { count += $0 }
        event.fire(2)
        event.fire(3)
        XCTAssertEqual(count, 5)
    }

    func testListenOnce() throws {
        let event = event()
        var count = 0
        event.listenOnce { count += 1 }
        event.fire()
        event.fire()
        XCTAssertEqual(count, 1)
    }

    func testArgListenOnce() throws {
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
        event.listen { registration, _ in
            count += 1
            if count == 2 { registration.cancel() }
        }
        event.fire()
        event.fire()
        event.fire()
        XCTAssertEqual(count, 2)
    }

    func testStringEventCancel() throws {
        let event: CSEvent<String> = event()
        var value: String? = nil
        event.listen {
            $0.cancel()
            value = $1
        }
        event.fire("first")
        XCTAssertEqual("first", value)
        event.fire("second")
    }

    func testEventPause() throws {
        let event = event()
        var count = 0
        let registration = event.listen { count += 1 }
        registration.pause { event.fire() }
        XCTAssertEqual(count, 0)
        event.fire()
        XCTAssertEqual(count, 1)
    }
}

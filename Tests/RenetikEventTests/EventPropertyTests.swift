import XCTest
@testable import RenetikEvent

/**
 * Simple event property use cases
 */
class EventPropertyTests: XCTestCase {

    func testOnChange() throws {
        let property = property("initial")
        var count = 0
        property.onChange { count += 1 }
        property.value = "second"
        property.value = "third"
        XCTAssertEqual(count, 2)
        XCTAssertEqual("third", property.value)
    }

    func testOnApply() throws {
        var count = 0
        let property = property("initial") { _ in count += 1 }.apply()
        property.value = "second"
        property.value = "third"
        XCTAssertEqual(count, 3)
        XCTAssertEqual("third", property.value)
    }

    func testArgListen() throws {
        var count = 0
        let property = property(0) { count += 1 }
        property.value += 2
        property.value += 3
        XCTAssertEqual(5, property.value)
        XCTAssertEqual(2, count)
    }

    func testEquals() throws {
        var count = 0
        let property = property(""){ count += 1 }
        property.value = "second"
        property.value = "second"
        XCTAssertEqual(count, 1)
        XCTAssertEqual("second", property.value)
    }

    func testOnChangeOnce() throws {
        var count = 0
        let property = property("")
        property.onChangeOnce { count += 1 }
        property.value = "second"
        property.value = "third"
        XCTAssertEqual(count, 1)
        XCTAssertEqual("third", property.value)
    }

    func testEventCancel() throws {
        var count = 0
        let property = property(0)
        property.onChange { registration, value in
            count += value
            if count > 2 { registration.cancel() }
        }
        property.value = 1
        property.value = 2
        property.value = 3
        XCTAssertEqual(count, 3)
    }

    func testEventPause() throws {
        var count = 0
        let property = property(0)
        let registration = property.onChange { count += $1 }
        registration.pause { property.value = 1 }
        XCTAssertEqual(count, 0)
        property.value = 2
        XCTAssertEqual(count, 2)
    }
}

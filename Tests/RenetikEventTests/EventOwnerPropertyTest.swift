import XCTest
@testable import RenetikEvent

/**
 * Event property unregister after owner niled
 */
class EventOwnerPropertyTest: XCTestCase {
    class SomeClass: CSEventOwnerBase {
        let string = property("initial value")
        init(argument: SomeClass? = nil) {
            super.init()
            register(argument?.string.onChange { [unowned self] in string.value = $0 })
        }
    }
    func testUnregisteredAfterNiled() throws {
        let instance1 = SomeClass()
        var instance2: SomeClass? = SomeClass(argument: instance1)
        let instance3 = SomeClass(argument: instance2)
        XCTAssertEqual(instance3.string.value, "initial value")
        instance1.string.value = "first value"
        XCTAssertEqual(instance3.string.value, "first value")
        instance2 = nil
        instance1.string.value = "second value"
        XCTAssertEqual(instance3.string.value, "first value")
    }
}

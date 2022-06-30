import XCTest
@testable import RenetikEvent

/**
 * Event property unregister after owner niled
 */
class EventOwnerPropertyTest: XCTestCase {
    class SomeClass: CSEventOwnerBase {
        let prop = property("initial value")
        init(arugment: SomeClass? = nil) {
            super.init()
            arugment?.also {
                register($0.prop.onChange { [unowned self] in prop.value = $0 })
            }
        }
    }
    func testUnregisteredAfterNilled() throws {
        let class1 = SomeClass()
        var class2: SomeClass? = SomeClass(arugment: class1)
        let class3 = SomeClass(arugment: class2)
        XCTAssertEqual(class3.prop.value, "initial value")
        class1.prop.value = "first value"
        XCTAssertEqual(class3.prop.value, "first value")
        class2 = nil
        class1.prop.value = "second value"
        XCTAssertEqual(class3.prop.value, "first value")
    }
}

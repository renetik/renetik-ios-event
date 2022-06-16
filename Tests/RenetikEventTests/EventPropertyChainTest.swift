import XCTest
@testable import RenetikEvent

class EventPropertyChainTests: XCTestCase {

    class Class1 {
        let prop = property("Class1InititalValue")
    }

    class Class2: CSEventOwnerBase {
        let prop = property("Class2InititalValue")
        var class1Registration: CSRegistration!
        init(arugment: Class1) {
            super.init()
            class1Registration = register(arugment.prop.onChange { [unowned self] value in
                class1Registration.pause {
                    prop.value = value
                }
            })
            prop.onChange {
                arugment.prop.value = "\($0)FromClass2"
            }
        }
    }
    let class1 = Class1()
    var class2: Class2? = nil

    func testListen() throws {
        class2 = Class2(arugment: class1)
        XCTAssertEqual(class1.prop.value, "Class1InititalValue")
        class1.prop.value = "Class1SecondValue"
        XCTAssertEqual(class2?.prop.value, "Class1SecondValue")
        XCTAssertEqual(class1.prop.value, "Class1SecondValueFromClass2")
        class2 = nil
        class1.prop.value = "Class1ThirdValue"
        XCTAssertEqual(class1.prop.value, "Class1ThirdValue")
    }
}

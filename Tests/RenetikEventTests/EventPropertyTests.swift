import XCTest
@testable import RenetikEvent

class EventPropertyTests: XCTestCase {
    
    class Class1 {
        let prop = property("Class1InititalValue")
    }

    class Class2: CSEventOwnerBase {
        let prop = property("Class2InititalValue")
        init(arugment: Class1) {
            super.init()
            register(arugment.prop
                    .onChange { [unowned self] in prop.value = $0 })
        }
    }

    let class1 = Class1()
    var class2: Class2? = nil

    func testListen() throws {
        class2 = Class2(arugment: class1)
        XCTAssertEqual(class1.prop.value, "Class1InititalValue")
        class1.prop.value = "Class1SecondValue"
        XCTAssertEqual(class2?.prop.value, "Class1SecondValue")
        class2 = nil
        class1.prop.value = "Class1ThirdValue"
        XCTAssertEqual(class2?.prop.value, nil)
    }
}

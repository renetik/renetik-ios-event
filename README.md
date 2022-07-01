[![Xcode - Build Analyze Test](https://github.com/renetik/renetik-ios-event/workflows/Xcode%20-%20Build%20Analyze%20Test/badge.svg)](https://github.com/renetik/renetik-ios-event/actions/workflows/objective-c-xcode.yml)
# Renetik iOS - Event & Property
#### [https://github.com/renetik/renetik-ios-event](https://github.com/renetik/renetik-ios-event/)
### [Documentation](https://renetik.github.io/renetik-ios-event/)
Framework to enjoy, improve and speed up your application development while writing readable code.
Used as library in many projects and improving it while developing new projects.
I am open for [Hire](https://renetik.github.io) or investment in my mobile app music production & perfromance project Renetik Instruments www.renetik.com.

## Installation
You can install using swift package manager for now using latest released version or master.

## Examples
```
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
```
```
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
```
```
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
```

```
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
```


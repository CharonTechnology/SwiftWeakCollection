import Foundation
import XCTest
@testable import WeakCollection

class Foo {
}

class Hello {
    let msg = "hello"
}

final class WeakCollectionTests: XCTestCase {
	func testWeakArray() {
		var array = WeakArray<Foo>()
		do {
			let foo = Foo()
			array.append(foo)
		}
		XCTAssertNil(array[0])
	}

	func testUnownedArray() {
		var array = UnownedArray<Foo>()
		weak var weakFoo: Foo?
		do {
			let foo = Foo()
			weakFoo = foo
			array.append(foo)
		}
		XCTAssertNil(weakFoo)
	}

    func testUnownedDictionary() {
        var dict = UnownedDictionary<String, Foo>()
        weak var weakFoo: Foo?
        do {
            let foo = Foo()
            weakFoo = foo
            dict["foo"] = foo

            XCTAssertNotNil(dict["foo"])
        }

        XCTAssertNil(weakFoo)
    }

    func testWeakDictionary() {
        var dict = WeakDictionary<String, Foo>()
        do {
            let foo = Foo()
            dict["foo"] = foo

            XCTAssertNotNil(dict["foo"])
        }
        XCTAssertNil(dict["foo"])
    }

	static var allTests = [
		("testWeakArray", testWeakArray),
		("testUnownedArray", testUnownedArray),
        ("testWeakDictionary", testWeakDictionary),
        ("testUnownedDictionary", testUnownedDictionary),
	]
}

import Foundation
import XCTest
@testable import WeakCollection

class Foo {
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

	static var allTests = [
		("testWeakArray", testWeakArray),
		("testUnownedArray", testUnownedArray)
	]
}

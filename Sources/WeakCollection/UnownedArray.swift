// SwiftWeakCollection - Collections to keep weak or unowned reference
// Written in 2019 by Natsuki Kawai <kawai@charon.tech>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to
// the public domain worldwide. This software is distributed without
// any warranty.
// You should have received a copy of the CC0 Public Domain Dedication
// along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

public struct UnownedArray<T: AnyObject> {
	public typealias Element = T
	public typealias Index = Array<T>.Index

	private var UnownedArray: [UnownedReference<T>] = []

	public init() {
	}
}

extension UnownedArray : ExpressibleByArrayLiteral {
	public init(arrayLiteral: Element...) {
		for element in arrayLiteral {
			self.append(element)
		}
	}
}

extension UnownedArray: MutableCollection {
	public subscript(position: Index) -> T {
		get {
			return UnownedArray[position].value
		}
		set {
			UnownedArray[position] = UnownedReference(newValue)
		}
	}

	public var startIndex: Index {
		get {
			return UnownedArray.startIndex
		}
	}

	public var endIndex: Index {
		get {
			return UnownedArray.endIndex
		}
	}

	public func index(after i: Index) -> Index {
		return UnownedArray.index(after: i)
	}
}

extension UnownedArray : RandomAccessCollection {
}

extension UnownedArray : RangeReplaceableCollection {
	public mutating func append(_ newElement: Element) {
		UnownedArray.append(UnownedReference(newElement))
	}
}

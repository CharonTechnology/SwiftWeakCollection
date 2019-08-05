public struct WeakArray<T: AnyObject> {
	public typealias Element = T?
	public typealias Index = Array<T?>.Index

	private var weakArray: [WeakReference<T>] = []

	public init() {
	}
}

extension WeakArray : ExpressibleByArrayLiteral {
	public init(arrayLiteral: Element...) {
		for element in arrayLiteral {
			self.append(element)
		}
	}
}

extension WeakArray: MutableCollection {
	public subscript(position: Index) -> T? {
		get {
			return weakArray[position].value
		}
		set {
			weakArray[position] = WeakReference(newValue)
		}
	}

	public var startIndex: Index {
		get {
			return weakArray.startIndex
		}
	}

	public var endIndex: Index {
		get {
			return weakArray.endIndex
		}
	}

	public func index(after i: Index) -> Index {
		return weakArray.index(after: i)
	}
}

extension WeakArray : RandomAccessCollection {
}

extension WeakArray : RangeReplaceableCollection {
	public mutating func append(_ newElement: Element) {
		weakArray.append(WeakReference(newElement))
	}
}

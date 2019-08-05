struct UnownedReference<T: AnyObject> {
	unowned var value: T
	init(_ value: T) {
		self.value = value
	}
}

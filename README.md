# WeakCollection

WeakCollection is a Swift library of collections to keep *weak* or *unowned* reference.

## Installation

Simply add WeakCollection to your package and dependency in `Package.swift`.

```swift
.package(url: "https://github.com/CharonTechnology/SwiftWeakCollection.git", from: "0.0.0"),
```

```swift
.target(name: "YourApplicationName", dependencies: ["WeakCollection"]),
```

## Usage

You can use WeakArray and UnownedArray as same as Array.

```swift
class Hello {
	let msg = "hello"
}
```

```swift
var weakArray: WeakArray<Hello>()
var element = Hello()  // Don't forget to keep one or more references!
weakArray.append(element)

// Note that the element type of WeakArray<Hello> is "Hello?".
print(weakArray[0]?.msg)  // will print hello.

element = Hello()  // Drop the reference.
print(weakArray[0]?.msg)  // will be nil.
```

```swift
var unownedArray: UnownedArray<Hello>()
let element = Hello()  // Don't forget to keep one or more references!
unownedArray.append(element!)

// The element type of UnownedArray<Hello> is "Hello".
print(unownedArray[0].msg)  // will print hello.

element = Hello()  // Drop the reference.
print(unownedArray[0].msg)  // Runtime error!
```

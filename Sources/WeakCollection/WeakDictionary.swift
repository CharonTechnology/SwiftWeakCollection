// SwiftWeakCollection - Collections to keep weak or unowned reference
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to
// the public domain worldwide. This software is distributed without
// any warranty.
// You should have received a copy of the CC0 Public Domain Dedication
// along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

public struct WeakDictionary<Key: Hashable, Value: AnyObject> {
    typealias WeakDictionaryType = [Key : WeakReference<Value>]
    public typealias DictionaryType = Dictionary<Key, Value?>

    public struct WeakDictionaryIndex: Comparable {
        let internalIndex: WeakDictionaryType.Index

        public static func < (lhs: WeakDictionary<Key, Value>.WeakDictionaryIndex, rhs: WeakDictionary<Key, Value>.WeakDictionaryIndex) -> Bool {
            return lhs.internalIndex < rhs.internalIndex
        }
    }

    private var internalDictionary: [Key : WeakReference<Value>] = [:]

    public init() {
    }
}

extension WeakDictionary: MutableCollection {
    public typealias Element = DictionaryType.Element
    public typealias Index = WeakDictionaryIndex

    public var startIndex: Index {
        return Index(internalIndex: internalDictionary.startIndex)
    }

    public var endIndex: Index {
        return Index(internalIndex: internalDictionary.endIndex)
    }

    public subscript(position: Index) -> Element {
        get {
            let element = internalDictionary[position.internalIndex]
            let value = element.value.value

            return Element(key: element.key, value: value)
        }
        set {
            internalDictionary[newValue.key] = WeakReference(newValue.value)
        }
    }

    public subscript(key: Key) -> Value? {
        get {
            return internalDictionary[key]?.value
        }
        set {
            // this is my preference, but it currently crashes the compiler
            // internalDictionary[key] = newValue.map({ WeakReference($0) }

            if let value = newValue {
                internalDictionary[key] = WeakReference(value)
            } else {
                internalDictionary[key] = nil
            }
        }
    }

    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        mutating get {
            if let value = self[key] {
                return value
            }

            let value = defaultValue()

            self[key] = value

            return value
        }
        set {
            self[key] = newValue
        }
    }

    public func index(after i: WeakDictionaryIndex) -> WeakDictionaryIndex {
        let after = internalDictionary.index(after: i.internalIndex)

        return WeakDictionaryIndex(internalIndex: after)
    }
}

extension WeakDictionary: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (k, v) in elements {
            internalDictionary[k] = WeakReference(v)
        }
    }
}


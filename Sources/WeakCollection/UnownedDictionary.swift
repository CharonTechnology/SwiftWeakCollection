// SwiftWeakCollection - Collections to keep weak or unowned reference
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to
// the public domain worldwide. This software is distributed without
// any warranty.
// You should have received a copy of the CC0 Public Domain Dedication
// along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

public struct UnownedDictionary<Key: Hashable, Value: AnyObject> {
    typealias UnownedDictionaryType = [Key : UnownedReference<Value>]
    public typealias DictionaryType = Dictionary<Key, Value>

    public struct UnownedDictionaryIndex: Comparable {
        let internalIndex: UnownedDictionaryType.Index

        public static func < (lhs: UnownedDictionary<Key, Value>.UnownedDictionaryIndex, rhs: UnownedDictionary<Key, Value>.UnownedDictionaryIndex) -> Bool {
            return lhs.internalIndex < rhs.internalIndex
        }
    }

    private var internalDictionary: [Key : UnownedReference<Value>] = [:]

    public init() {
    }
}

extension UnownedDictionary: MutableCollection {
    public typealias Element = DictionaryType.Element
    public typealias Index = UnownedDictionaryIndex

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
            internalDictionary[newValue.key] = UnownedReference(newValue.value)
        }
    }

    public subscript(key: Key) -> Value? {
        get {
            return internalDictionary[key]?.value
        }
        set {
            // this is my preference, but it currently crashes the compiler
            // internalDictionary[key] = newValue.map({ UnownedReference($0) }

            if let value = newValue {
                internalDictionary[key] = UnownedReference(value)
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

    public func index(after i: UnownedDictionaryIndex) -> UnownedDictionaryIndex {
        let after = internalDictionary.index(after: i.internalIndex)

        return UnownedDictionaryIndex(internalIndex: after)
    }
}

extension UnownedDictionary: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (k, v) in elements {
            internalDictionary[k] = UnownedReference(v)
        }
    }
}

import Foundation

public extension Array {

    func at(index: Int) -> Array.Element? {
        guard index >= 0 && index <= count - 1 else { return nil }
        return self[index]
    }
    
    func first<T: Equatable>(where keyPath: KeyPath<Element, T>, equals value: T) -> Element? {
        return first { $0[keyPath: keyPath] == value }
    }
    
    mutating func insertComparing(_ element: Element,
                                  using areInIncreasingOrder: (Element, Element) -> Bool) {
        insert(element, at: insertionIndex(of: element, using: areInIncreasingOrder))
    }
}

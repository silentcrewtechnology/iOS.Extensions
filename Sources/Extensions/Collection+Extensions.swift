import Foundation

extension Collection {
    func insertionIndex(of element: Element,
                        using areInIncreasingOrder: (Element, Element) -> Bool) -> Index {
        return firstIndex(where: { !areInIncreasingOrder($0, element) }) ?? endIndex
    }
}

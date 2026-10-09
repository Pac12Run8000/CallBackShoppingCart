import Foundation

enum MockCartError: LocalizedError {
    case unableToAddItem

    var errorDescription: String? {
        switch self {
        case .unableToAddItem:
            return "Unable to add the item to your cart."
        }
    }
}


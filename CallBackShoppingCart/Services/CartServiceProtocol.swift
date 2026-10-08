import Foundation

protocol CartServiceProtocol {
    func addToCart(
        product: Product,
        completion: @escaping (Result<CartItem, Error>) -> Void
    )
}

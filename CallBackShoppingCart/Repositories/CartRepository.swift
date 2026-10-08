import Foundation

protocol CartRepository {
    func addToCart(
        product: Product,
        completion: @escaping (Result<CartItem, Error>) -> Void
    )
}

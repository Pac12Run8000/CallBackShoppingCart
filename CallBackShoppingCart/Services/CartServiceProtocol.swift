import Foundation

protocol CartServiceProtocol {
    
    var products: [Product] { get }
    
    func addToCart(
        product: Product,
        completion: @escaping (Result<CartItem, Error>) -> Void
    )
}

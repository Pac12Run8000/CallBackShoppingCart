import Foundation

@MainActor
protocol CartRepository {
    
    var products: [Product] { get }
    
    func addToCart(
        product: Product,
        completion: @escaping @MainActor (Result<CartItem, Error>) -> Void
    )

    func saveCart(items: [CartItem])

    func loadCart() -> [CartItem]
}



import Foundation

@MainActor
protocol CartRepository {
    func addToCart(
        product: Product,
        completion: @escaping @MainActor (Result<CartItem, Error>) -> Void
    )

    func saveCart(items: [CartItem])

    func loadCart() -> [CartItem]
}



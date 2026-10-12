import Foundation

final class MockCartService: CartServiceProtocol {
    
    let products: [Product] = [
        Product(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "Apple",
            price: 1.50
        ),
        Product(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "Banana",
            price: 0.75
        )
    ]

    func addToCart(product: Product, completion: @escaping (Result<CartItem, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let cartItem = CartItem(product: product, quantity: 1)

            completion(.success(cartItem))
        }
    }
}

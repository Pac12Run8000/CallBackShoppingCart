import Foundation

final class MockCartService: CartServiceProtocol {

    func addToCart(product: Product, completion: @escaping (Result<CartItem, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let cartItem = CartItem(product: product, quantity: 1)

            completion(.success(cartItem))
        }
    }
}

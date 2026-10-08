import Foundation

final class DefaultCartRepository: CartRepository {

    private let service: CartServiceProtocol

    init(service: CartServiceProtocol) {
        self.service = service
    }

    func addToCart(product: Product, completion: @escaping (Result<CartItem, Error>) -> Void) {
        service.addToCart(product: product) { result in
            completion(result)
        }
    }
}

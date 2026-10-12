import Foundation

final class DefaultCartRepository: CartRepository {

    private let service: CartServiceProtocol
    private let cartStorageKey = "savedShoppingCart"
    
    var products: [Product] {
        return service.products
    }

    init(service: CartServiceProtocol) {
        self.service = service
    }

    func addToCart(product: Product, completion: @escaping @MainActor (Result<CartItem, Error>) -> Void) {
        service.addToCart(product: product) { result in
            completion(result)
        }
    }

    func saveCart(items: [CartItem]) {
        guard let data = try? JSONEncoder().encode(items) else {
            return
        }

        UserDefaults.standard.set(data, forKey: cartStorageKey)
    }

    func loadCart() -> [CartItem] {
        guard let data = UserDefaults.standard.data(forKey: cartStorageKey),
              let items = try? JSONDecoder().decode([CartItem].self, from: data)
        else {
            return []
        }

        return items
    }
}

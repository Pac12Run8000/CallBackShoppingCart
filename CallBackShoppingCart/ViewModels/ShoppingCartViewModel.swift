import Foundation
import Combine

@MainActor
final class ShoppingCartViewModel: ObservableObject {

    @Published private(set) var items: [CartItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    var subtotal: Double {
        items.reduce(0.0) { total, cartItem in
            total + cartItem.product.price * Double(cartItem.quantity)
        }
    }
    
    var totalItemCount: Int {
        items.reduce(0) { total, cartItem in
            total + cartItem.quantity
        }
    }

    private let repository: CartRepository

    init(repository: CartRepository) {
        self.repository = repository
    }

    func add(product: Product) {
        isLoading = true
        errorMessage = nil

        repository.addToCart(product: product) { [weak self] result in
            guard let self else { return }

            self.isLoading = false

            switch result {
            case .success(let cartItem):
                if let index = self.items.firstIndex(where: { $0.product.id == cartItem.product.id }) {
                    self.items[index].quantity += cartItem.quantity
                } else {
                    self.items.append(cartItem)
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

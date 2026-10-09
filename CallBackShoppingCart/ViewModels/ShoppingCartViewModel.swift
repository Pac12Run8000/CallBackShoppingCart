import Foundation
import Combine

@MainActor
final class ShoppingCartViewModel: ObservableObject {

    @Published private(set) var items: [CartItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    var subtotal: Double {
        return items.reduce(0.0, { $0 + $1.product.price * Double($1.quantity) })
    }
    
    var totalItemCount: Int {
        return items.reduce(0, { $0 + $1.quantity })
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
    
    func remove(product: Product) {
        items.removeAll {
            $0.product.id == product.id
        }
    }
    
    func decreaseQuantity(for product: Product) {
        guard let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) else {
            return
        }

        if items[index].quantity > 1 {
            items[index].quantity -= 1
        } else {
            items.remove(at: index)
        }
    }
    
    func increaseQuantity(for product: Product) {
        guard let index = items.firstIndex(where: {
            $0.product.id == product.id
        }) else {
            return
        }

        items[index].quantity += 1
    }
    
    func clearCart() {
        items.removeAll()
    }
}

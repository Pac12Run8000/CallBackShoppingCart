import Foundation
import Combine

@MainActor
final class ShoppingCartViewModel: ObservableObject {

    @Published private(set) var items: [CartItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

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
                self.items.append(cartItem)

            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

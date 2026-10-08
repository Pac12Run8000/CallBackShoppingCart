import SwiftUI

@main
struct CallBackShoppingCartApp: App {

    var body: some Scene {
        WindowGroup {
            ShoppingCartView(
                viewModel: ShoppingCartViewModel(
                    repository: DefaultCartRepository(
                        service: MockCartService()
                    )
                )
            )
        }
    }
}

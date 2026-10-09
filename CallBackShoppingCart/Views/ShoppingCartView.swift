import Foundation
import SwiftUI

struct ShoppingCartView: View {

    @StateObject private var viewModel: ShoppingCartViewModel

    init(viewModel: ShoppingCartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private let apple = Product(
        id: UUID(),
        name: "Apple",
        price: 1.50
    )

    var body: some View {
        VStack(spacing: 20) {
            Text("Shopping Cart")
                .font(.title)

            Text("Items: \(viewModel.totalItemCount)")
            
            // Update shopping cart view
            
            ForEach(viewModel.items.indices, id: \.self) { index in
                let cartItem = viewModel.items[index]

                HStack {
                    VStack(alignment: .leading) {
                        Text(cartItem.product.name)
                            .font(.headline)

                        Text(
                            cartItem.product.price * Double(cartItem.quantity),
                            format: .currency(code: "USD")
                        )
                        .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text("Qty: \(cartItem.quantity)")
                }
            }
            
            HStack {
                Text("Subtotal:")
                    .fontWeight(.semibold)

                Spacer()

                Text(viewModel.subtotal, format: .currency(code: "USD"))
                    .fontWeight(.semibold)
            }
            
            // Update shopping cart view

            Button("Add Apple to Cart") {
                viewModel.add(product: apple)
            }
            .disabled(viewModel.isLoading)

            if viewModel.isLoading {
                ProgressView("Adding to cart...")
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
            }
        }
        .padding()
    }
}

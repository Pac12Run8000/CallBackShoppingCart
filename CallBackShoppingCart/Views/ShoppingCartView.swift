import Foundation
import SwiftUI

struct ShoppingCartView: View {

    @StateObject private var viewModel: ShoppingCartViewModel

    init(viewModel: ShoppingCartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private static let apple = Product(
        id: UUID(),
        name: "Apple",
        price: 1.50
    )
    private static let banana = Product(
        id: UUID(),
        name: "Banana",
        price: 0.75
    )

    var body: some View {
        VStack(spacing: 20) {
            Text("Shopping Cart")
                .font(.title)

            Text("Items: \(viewModel.totalItemCount)")
            
            // Update shopping cart view
            
            if viewModel.items.isEmpty {
                Text("Your cart is empty.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.items.indices, id: \.self) { index in
                    let cartItem = viewModel.items[index]

                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(cartItem.product.name)
                                .font(.headline)

                            Text(
                                cartItem.product.price * Double(cartItem.quantity),
                                format: .currency(code: "USD")
                            )
                            .foregroundStyle(.secondary)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 8) {
                            HStack(spacing: 12) {
                                Button {
                                    viewModel.decreaseQuantity(for: cartItem.product)
                                } label: {
                                    Image(systemName: "minus.circle")
                                }

                                Text("Qty: \(cartItem.quantity)")
                                    

                                Button {
                                    viewModel.increaseQuantity(for: cartItem.product)
                                } label: {
                                    Image(systemName: "plus.circle")
                                }
                            }
                            
                        }
                    }
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

            HStack(spacing: 16) {
                Button("Add Apple") {
                    viewModel.add(product: Self.apple)
                }

                Button("Add Banana") {
                    viewModel.add(product: Self.banana)
                }
            }
            .disabled(viewModel.isLoading)
            
            Button("Clear Cart") {
                viewModel.clearCart()
            }
            .disabled(viewModel.items.isEmpty || viewModel.isLoading)

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

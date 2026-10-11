import Foundation
import SwiftUI

struct ShoppingCartView: View {

    @StateObject private var viewModel: ShoppingCartViewModel
    @State private var showClearConfirmation = false

    init(viewModel: ShoppingCartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private static let apple = Product(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        name: "Apple",
        price: 1.50
    )

    private static let banana = Product(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
        name: "Banana",
        price: 0.75
    )

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Shopping Cart")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Items: \(viewModel.totalItemCount)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Image(systemName: "cart")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
                
                // Update shopping cart view
                
                if viewModel.items.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "cart.badge.questionmark")
                            .font(.system(size: 44))
                            .foregroundStyle(.secondary)

                        Text("Your cart is empty.")
                            .font(.headline)
                            .foregroundStyle(.secondary)

                        Text("Add a product to get started.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
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
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color(.secondarySystemBackground),
                        in: RoundedRectangle(cornerRadius: 12)
                    )
                }
                
                
                HStack {
                    Text("Subtotal:")
                        .fontWeight(.semibold)

                    Spacer()

                    Text(viewModel.subtotal, format: .currency(code: "USD"))
                        .fontWeight(.bold)
                }
                .font(.headline)
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(
                    Color(.secondarySystemBackground),
                    in: RoundedRectangle(cornerRadius: 12)
                )
                
                // Update shopping cart view

                HStack(spacing: 12) {
                    Button("Add Apple") {
                        viewModel.add(product: Self.apple)
                    }
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)

                    Button("Add Banana") {
                        viewModel.add(product: Self.banana)
                    }
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                }
                .disabled(viewModel.isLoading)
                
                Button("Clear Cart", role: .destructive) {
                    showClearConfirmation = true
                }
                .fontWeight(.semibold)
                .foregroundStyle(.red)
                .disabled(viewModel.items.isEmpty || viewModel.isLoading)

                if viewModel.isLoading {
                    ProgressView("Adding to cart...")
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                if let successMessage = viewModel.successMessage {
                    Text(successMessage)
                        .foregroundStyle(.green)
                        .transition(.opacity)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding()
        }
        .confirmationDialog(
            "Clear Shopping Cart?",
            isPresented: $showClearConfirmation,
            titleVisibility: .visible
        ) {
            Button("Clear Cart", role: .destructive) {
                viewModel.clearCart()
            }

            Button("Cancel", role: .cancel) {
                // Keep the cart unchanged.
            }
        } message: {
            Text("This will remove all products from your cart.")
        }
        
    }
}

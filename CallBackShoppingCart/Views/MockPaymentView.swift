import SwiftUI

struct MockPaymentView: View {
    
    let items: [CartItem]
    let subtotal: Double

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "creditcard")
                .font(.system(size: 60))
                .foregroundStyle(.blue)

            Text("Mock Payment")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("This is a simulated payment screen.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 16) {
                Text("Order Summary")
                    .font(.headline)

                ForEach(items, id: \.product.id) { item in
                    HStack {
                        Text(item.product.name)

                        Spacer()

                        Text("Qty: \(item.quantity)")
                    }
                }

                Divider()

                HStack {
                    Text("Subtotal:")
                        .fontWeight(.semibold)

                    Spacer()

                    Text(subtotal, format: .currency(code: "USD"))
                        .fontWeight(.bold)
                }
            }
            .padding(16)
            .background(
                Color(.secondarySystemBackground),
                in: RoundedRectangle(cornerRadius: 12)
            )

            Text("No real payment will be processed.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

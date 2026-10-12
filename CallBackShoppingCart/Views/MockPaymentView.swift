import SwiftUI

struct MockPaymentView: View {

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

#Preview {
    NavigationStack {
        MockPaymentView()
    }
}

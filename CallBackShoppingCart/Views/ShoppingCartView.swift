import Foundation
import SwiftUI

struct ShoppingCartView: View {

    @StateObject private var viewModel: ShoppingCartViewModel

    init(viewModel: ShoppingCartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Text("Items: \(viewModel.items.count)")
    }
}

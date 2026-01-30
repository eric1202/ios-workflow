import SwiftUI

struct AddStockBar: View {
    @Bindable var viewModel: StockViewModel

    var body: some View {
        HStack {
            TextField(String(localized: "Enter stock symbol"), text: $viewModel.newSymbol)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.characters)

            Button(String(localized: "Add")) {
                Task { await viewModel.addStock() }
            }
            .disabled(viewModel.newSymbol.isEmpty)
        }
    }
}

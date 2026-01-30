import SwiftUI

struct ContentView: View {
    @State private var viewModel = StockViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.stocks) { stock in
                    NavigationLink(value: stock) {
                        StockRow(stock: stock)
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationDestination(for: Stock.self) { stock in
                StockDetailView(stock: stock)
            }
            .refreshable {
                await viewModel.refresh()
            }
            .overlay {
                if viewModel.stocks.isEmpty {
                    ContentUnavailableView(String(localized: "No stocks yet"), systemImage: "chart.line.uptrend.xyaxis")
                }
            }
            .navigationTitle("Stock Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button {
                            Task { await viewModel.refresh() }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                AddStockBar(viewModel: viewModel)
                    .padding()
                    .background(.bar)
            }
        }
        .task {
            await viewModel.refresh()
        }
    }
}

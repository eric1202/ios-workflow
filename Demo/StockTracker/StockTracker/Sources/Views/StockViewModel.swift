import Foundation

@Observable
final class StockViewModel {
    var stocks: [Stock] = []
    var newSymbol = ""
    var isLoading = false
    var errorMessage: String?

    private let store = StockStore.shared
    private let api = StockAPIService.shared

    init() {
        stocks = store.load()
    }

    func addStock() async {
        guard !newSymbol.isEmpty else { return }
        let symbol = newSymbol.uppercased()
        newSymbol = ""

        // 先添加占位
        var stock = Stock(symbol: symbol)
        stocks.append(stock)
        store.save(stocks)

        // 获取实时数据
        await fetchQuote(for: symbol)
    }

    func refresh() async {
        isLoading = true
        errorMessage = nil

        for stock in stocks {
            await fetchQuote(for: stock.symbol)
        }

        isLoading = false
    }

    private func fetchQuote(for symbol: String) async {
        do {
            let quote = try await api.fetchQuote(symbol: symbol)
            if let index = stocks.firstIndex(where: { $0.symbol == symbol }) {
                stocks[index].name = quote.name
                stocks[index].price = quote.price
                stocks[index].change = quote.change
                stocks[index].changePercent = quote.changePercent
                store.save(stocks)
            }
        } catch {
            errorMessage = "获取 \(symbol) 失败"
        }
    }

    func delete(at offsets: IndexSet) {
        stocks.remove(atOffsets: offsets)
        store.save(stocks)
    }
}

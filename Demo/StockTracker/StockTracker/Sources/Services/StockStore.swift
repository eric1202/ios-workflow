import Foundation

final class StockStore {
    static let shared = StockStore()
    private let key = "watchlist"

    func save(_ stocks: [Stock]) {
        if let data = try? JSONEncoder().encode(stocks) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [Stock] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let stocks = try? JSONDecoder().decode([Stock].self, from: data)
        else { return [] }
        return stocks
    }
}

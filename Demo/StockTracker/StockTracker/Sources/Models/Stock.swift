import Foundation

struct Stock: Identifiable, Codable, Hashable {
    let id: UUID
    var symbol: String
    var name: String
    var price: Double
    var change: Double
    var changePercent: Double

    init(symbol: String, name: String = "", price: Double = 0, change: Double = 0, changePercent: Double = 0) {
        self.id = UUID()
        self.symbol = symbol.uppercased()
        self.name = name
        self.price = price
        self.change = change
        self.changePercent = changePercent
    }
}

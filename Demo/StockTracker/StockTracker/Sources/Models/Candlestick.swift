import Foundation

struct Candlestick: Identifiable {
    let id = UUID()
    let date: Date
    let open: Double
    let high: Double
    let low: Double
    let close: Double

    var isGain: Bool { close >= open }
}

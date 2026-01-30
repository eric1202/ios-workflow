import Foundation

struct StockQuote {
    let symbol: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
}

final class StockAPIService {
    static let shared = StockAPIService()

    private let apiKey = "d5u50l1r01qtjet21e10d5u50l1r01qtjet21e1g"
    private let baseURL = "https://finnhub.io/api/v1"

    func fetchQuote(symbol: String) async throws -> StockQuote {
        let upperSymbol = symbol.uppercased()
        let urlString = "\(baseURL)/quote?symbol=\(upperSymbol)&token=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let price = json["c"] as? Double,
              let change = json["d"] as? Double,
              let changePercent = json["dp"] as? Double
        else {
            throw APIError.parseError
        }

        return StockQuote(
            symbol: upperSymbol,
            name: upperSymbol,
            price: price,
            change: change,
            changePercent: changePercent
        )
    }

    func fetchCandlesticks(symbol: String, days: Int = 30) async throws -> [Candlestick] {
        let upperSymbol = symbol.uppercased()
        let to = Int(Date().timeIntervalSince1970)
        let from = to - (days * 24 * 60 * 60)

        let urlString = "\(baseURL)/stock/candle?symbol=\(upperSymbol)&resolution=D&from=\(from)&to=\(to)&token=\(apiKey)"

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        // 检查是否有权限错误
        if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let error = json["error"] as? String {
            throw APIError.noAccess(error)
        }

        return try parseCandlesticks(data)
    }

    private func parseCandlesticks(_ data: Data) throws -> [Candlestick] {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let timestamps = json["t"] as? [Int],
              let opens = json["o"] as? [Double],
              let highs = json["h"] as? [Double],
              let lows = json["l"] as? [Double],
              let closes = json["c"] as? [Double]
        else {
            throw APIError.parseError
        }

        var candlesticks: [Candlestick] = []
        for i in 0..<timestamps.count {
            let date = Date(timeIntervalSince1970: Double(timestamps[i]))
            candlesticks.append(Candlestick(
                date: date, open: opens[i], high: highs[i], low: lows[i], close: closes[i]
            ))
        }
        return candlesticks
    }
}

enum APIError: Error {
    case invalidURL
    case parseError
    case networkError
    case noAccess(String)
}

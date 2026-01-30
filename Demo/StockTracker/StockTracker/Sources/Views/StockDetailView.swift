import SwiftUI

struct StockDetailView: View {
    let stock: Stock
    @State private var candlesticks: [Candlestick] = []
    @State private var selectedCandle: Candlestick?
    @State private var isLoading = true
    @State private var errorMessage: String?

    private let api = StockAPIService.shared

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerView
                chartSection
                if !candlesticks.isEmpty {
                    statsSection
                }
            }
            .padding()
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await loadData()
        }
    }

    // MARK: - Header
    private var headerView: some View {
        VStack(spacing: 8) {
            Text(stock.name.isEmpty ? stock.symbol : stock.name)
                .font(.title2)
                .fontWeight(.semibold)

            Text(String(format: "$%.2f", displayPrice))
                .font(.system(size: 42, weight: .bold, design: .rounded))

            HStack(spacing: 4) {
                Image(systemName: displayChange >= 0 ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                Text(String(format: "%+.2f (%.2f%%)", displayChange, displayChangePercent))
            }
            .font(.headline)
            .foregroundStyle(displayChange >= 0 ? .green : .red)
        }
        .padding()
    }

    // MARK: - Chart
    private var chartSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(String(localized: "K-Line Chart"))
                    .font(.headline)
                Spacer()
                Text(String(localized: "30 Days"))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if isLoading {
                ProgressView()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
            } else if let error = errorMessage {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text(error)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity)
            } else if candlesticks.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "chart.line.downtrend.xyaxis")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text(String(localized: "No K-Line Data"))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(height: 250)
                .frame(maxWidth: .infinity)
            } else {
                CandlestickChart(candlesticks: candlesticks, selectedCandle: $selectedCandle)
                    .frame(height: 250)
            }

            if let candle = selectedCandle {
                selectedCandleInfo(candle)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func selectedCandleInfo(_ candle: Candlestick) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(candle.date, format: .dateTime.month().day())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            infoItem(String(localized: "Open"), candle.open)
            infoItem(String(localized: "High"), candle.high)
            infoItem(String(localized: "Low"), candle.low)
            infoItem(String(localized: "Close"), candle.close)
        }
        .padding(.top, 8)
    }

    private func infoItem(_ label: String, _ value: Double) -> some View {
        VStack {
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(String(format: "%.2f", value))
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(width: 50)
    }

    // MARK: - Stats
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "Statistics"))
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                statCard(String(localized: "30D High"), highestPrice, .green)
                statCard(String(localized: "30D Low"), lowestPrice, .red)
                statCard(String(localized: "Average"), averagePrice, .blue)
                statCard(String(localized: "Volatility"), volatility, .orange)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func statCard(_ title: String, _ value: Double, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(String(format: "$%.2f", value))
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Computed Properties
    private var displayPrice: Double {
        candlesticks.last?.close ?? stock.price
    }

    private var displayChange: Double {
        guard let last = candlesticks.last, let first = candlesticks.first else {
            return stock.change
        }
        return last.close - first.open
    }

    private var displayChangePercent: Double {
        guard let first = candlesticks.first, first.open > 0 else {
            return stock.changePercent
        }
        return (displayChange / first.open) * 100
    }

    private var highestPrice: Double {
        candlesticks.map(\.high).max() ?? 0
    }

    private var lowestPrice: Double {
        candlesticks.map(\.low).min() ?? 0
    }

    private var averagePrice: Double {
        guard !candlesticks.isEmpty else { return 0 }
        return candlesticks.map(\.close).reduce(0, +) / Double(candlesticks.count)
    }

    private var volatility: Double {
        highestPrice - lowestPrice
    }

    // MARK: - Methods
    private func loadData() async {
        do {
            candlesticks = try await api.fetchCandlesticks(symbol: stock.symbol)
        } catch APIError.noAccess(_) {
            errorMessage = String(localized: "No Access")
        } catch {
            errorMessage = String(localized: "Load Failed")
        }
        isLoading = false
    }
}

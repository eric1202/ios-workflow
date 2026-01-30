import SwiftUI

struct StockRow: View {
    let stock: Stock

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stock.symbol)
                    .font(.headline)
                Text(stock.name.isEmpty ? "—" : stock.name)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(String(format: "$%.2f", stock.price))
                    .font(.headline)
                Text(String(format: "%+.2f%%", stock.changePercent))
                    .font(.caption)
                    .foregroundStyle(stock.change >= 0 ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}

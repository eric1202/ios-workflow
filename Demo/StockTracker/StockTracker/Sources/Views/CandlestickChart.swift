import SwiftUI
import Charts

struct CandlestickChart: View {
    let candlesticks: [Candlestick]
    @Binding var selectedCandle: Candlestick?

    var body: some View {
        Chart {
            ForEach(candlesticks) { candle in
                // 影线（高低线）
                RectangleMark(
                    x: .value("Date", candle.date, unit: .day),
                    yStart: .value("Low", candle.low),
                    yEnd: .value("High", candle.high),
                    width: 1
                )
                .foregroundStyle(candleColor(candle))

                // K线实体
                RectangleMark(
                    x: .value("Date", candle.date, unit: .day),
                    yStart: .value("Open", candle.open),
                    yEnd: .value("Close", candle.close),
                    width: 6
                )
                .foregroundStyle(candleColor(candle))
            }

            // 选中高亮线
            if let selected = selectedCandle {
                RuleMark(x: .value("Selected", selected.date, unit: .day))
                    .foregroundStyle(.blue.opacity(0.3))
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 3]))

                // 收盘价圆点
                PointMark(
                    x: .value("Date", selected.date, unit: .day),
                    y: .value("Close", selected.close)
                )
                .foregroundStyle(.blue)
                .symbolSize(80)
            }
        }
        .chartYScale(domain: yAxisDomain)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 7)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month().day())
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle()
                    .fill(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture { location in
                        selectCandle(at: location, proxy: proxy, geo: geo)
                    }
            }
        }
    }

    private var yAxisDomain: ClosedRange<Double> {
        guard let minLow = candlesticks.map(\.low).min(),
              let maxHigh = candlesticks.map(\.high).max() else {
            return 0...100
        }
        let padding = (maxHigh - minLow) * 0.1
        return (minLow - padding)...(maxHigh + padding)
    }

    private func selectCandle(at location: CGPoint, proxy: ChartProxy, geo: GeometryProxy) {
        let x = location.x - geo[proxy.plotFrame!].origin.x
        guard let date: Date = proxy.value(atX: x) else { return }
        selectedCandle = candlesticks.min(by: {
            abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date))
        })
    }

    private func candleColor(_ candle: Candlestick) -> Color {
        if selectedCandle?.id == candle.id {
            return candle.isGain ? .green : .red
        }
        return (candle.isGain ? Color.green : Color.red).opacity(selectedCandle == nil ? 1 : 0.4)
    }
}

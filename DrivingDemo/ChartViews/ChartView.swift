//
//  ChartView.swift
//  DrivingDemo
//
//  Created by Vishal on 17/05/21.
//

import SwiftUI
import RealmSwift
import SwiftUICharts

struct ChartView: View {
    @State var expenses: [Expense]?
    @State var filterExpense: [Expense]?
    @State var realm: Realm
    @State var sort: String = "All"
    
    @State var chartData: LineChartData = LineChartData(dataSets: LineDataSet(dataPoints: []))
    @State fileprivate var sortType: SortType = .all
    
    var body: some View {
        VStack {
            LineChart(chartData: chartData)
                .touchOverlay(chartData: chartData, specifier: "%.2f")
                .xAxisLabels(chartData: chartData)
                .yAxisLabels(chartData: chartData)
                .averageLine(chartData: chartData, strokeStyle: StrokeStyle(lineWidth: 1, dash: [5,10]))
                .infoBox(chartData: chartData)
                .headerBox(chartData: chartData)
            
            HStack {
                Spacer()
                Menu("Sort Expenses by \(sortType.rawValue)") {
                    Button("Fuel") {
//                        sort = "Fuel"
//                        filterExpense = expenses?.filter{ $0.type.rawValue.contains("Fuel") }
                        sortType = .fuel
                        setCharData()
                    }
                    Button("Service") {
//                        sort = "Service"
//                        filterExpense = expenses?.filter{ $0.type.rawValue.contains("Service") }
                        sortType = .service
                        setCharData()
                    }
                    Button("All") {
//                        sort = "All"
//                        filterExpense = expenses
                        sortType = .all
                        setCharData()
                    }
                }
            }
            
//            List {
//                ForEach(filterExpense ?? [], id: \.self) { expenses in
//                    ExpenseRowView(expense: expenses)
//                        .onTapGesture {
//                            print(expenses)
//                        }
//                }
//            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            getExpenses()
        }
    }
}

fileprivate extension ChartView {
    
    enum SortType: String {
        case fuel = "Fuel"
        case service = "Service"
        case all = "All"
    }
    
    
    func getExpenses() {
        let data = realm.objects(Expense.self)
        self.expenses = Array(data)
        self.filterExpense = expenses!
        setCharData()
    }
    
    func setCharData() {
        
        switch sortType {
        case .all:
            filterExpense = expenses
        default:
            filterExpense = expenses?.filter{ $0.type.rawValue.contains(sortType.rawValue) }
        }
        
        var monthlyExpenses: [Double] = [Double](repeating: 0.0, count: 12)
        
        for count in 0..<monthArray.count {
            let a = filterExpense?.filter{ $0.date.contains(monthArray[count])}
            a?.map{ monthlyExpenses[count] += Double($0.price) ?? 0.0 }
        }
        
        var data: [LineChartDataPoint] = []
        
        for count in 0..<monthlyExpenses.count {
            data.append(LineChartDataPoint(value: monthlyExpenses[count], xAxisLabel: monthArray[count], description: monthArray[count]))
        }
        
        
        let metaData: ChartMetadata = ChartMetadata(title: "Expenses", subtitle: "Monthly Expenses")
        
        let style: LineChartStyle = LineChartStyle(infoBoxPlacement: .infoBox(isStatic: false),
                                                   infoBoxContentAlignment: .vertical,
                                                   infoBoxBorderColour: Color.black,
                                                   infoBoxBorderStyle: StrokeStyle(lineWidth: 1),
                                                   markerType: .vertical(attachment: .line(dot: .style(DotStyle()))),
                                                   xAxisLabelPosition: .bottom,
                                                   xAxisLabelColour: Color.black,
                                                   xAxisLabelsFrom: .dataPoint(rotation: .degrees(0)),
                                                   yAxisLabelPosition: .leading,
                                                   yAxisLabelColour: Color.black,
                                                   yAxisNumberOfLabels: 5,
                                                   globalAnimation: .default)
        
        let chartData: LineChartData = LineChartData(dataSets: LineDataSet(dataPoints: data),
                                                     metadata: metaData,
                                                     chartStyle: style)
        
        self.chartData = chartData
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}

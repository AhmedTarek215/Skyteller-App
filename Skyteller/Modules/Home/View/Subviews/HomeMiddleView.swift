import SwiftUI

struct HomeMiddleView: View {
    let forecast: ForecastResponse
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("3-DAY FORECAST")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(themeManager.textColor.opacity(0.6))
                .padding(.bottom, 10)
            
            if let days = forecast.forecast?.forecastday {
                ForEach(Array(days.prefix(3).enumerated()), id: \.offset) { index, dayForecast in
                    NavigationLink(destination: HourlyForecastView(dayForecast: dayForecast)) {
                        HStack {
                            Text(formatDate(dayForecast.date))
                                .frame(width: 80, alignment: .leading)
                            
                            Spacer()
                            
                            if let iconUrlString = dayForecast.day?.condition?.icon,
                               let url = URL(string: "https:" + iconUrlString) {
                                AsyncImage(url: url) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 30, height: 30)
                            } else {
                                Image(systemName: "cloud.sun.fill") // Fallback
                                    .frame(width: 30, height: 30)
                            }
                            
                            Spacer()
                            
                            Text("\(Int(dayForecast.day?.mintemp_c ?? 0))°")
                                .frame(width: 40, alignment: .trailing)
                                .foregroundColor(themeManager.textColor.opacity(0.6))
                            
                            Text("\(Int(dayForecast.day?.maxtemp_c ?? 0))°")
                                .frame(width: 40, alignment: .trailing)
                        }
                        .font(.system(size: 18, weight: .medium))
                        .padding(.vertical, 10)
                    }
                    
                    if index < min(days.count, 3) - 1 {
                        Divider()
                            .background(themeManager.textColor.opacity(0.3))
                    }
                }
            }
        }
        .padding()
        .background(themeManager.isMorning ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
        .cornerRadius(20)
        .foregroundColor(themeManager.textColor)
    }
    
    func formatDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "Unknown" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
}

#Preview {
    HomeMiddleView(forecast: ForecastResponse(
        location: Location(name: "San Francisco"),
        current: nil,
        forecast: Forecast(forecastday: [
            ForecastDay(date: "2026-06-23", day: Day(maxtemp_c: 24.0, mintemp_c: 16.0, avgvis_km: 10.0, condition: WeatherCondition(text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")), hour: nil),
            ForecastDay(date: "2026-06-24", day: Day(maxtemp_c: 23.0, mintemp_c: 15.0, avgvis_km: 10.0, condition: WeatherCondition(text: "Cloudy", icon: "//cdn.weatherapi.com/weather/64x64/day/119.png")), hour: nil),
            ForecastDay(date: "2026-06-25", day: Day(maxtemp_c: 20.0, mintemp_c: 14.0, avgvis_km: 10.0, condition: WeatherCondition(text: "Rain", icon: "//cdn.weatherapi.com/weather/64x64/day/308.png")), hour: nil)
        ])
    ))
    .padding()
    .background(Color.blue)
    .environmentObject(ThemeManager())
}

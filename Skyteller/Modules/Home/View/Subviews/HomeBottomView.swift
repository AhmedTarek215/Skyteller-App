import SwiftUI

struct HomeBottomView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        if let forecast = viewModel.forecastResponse {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                WeatherInfoCard(
                    title: "VISIBILITY",
                    icon: "eye.fill",
                    value: "\(Int(forecast.current?.vis_km ?? 0)) km"
                )
                
                WeatherInfoCard(
                    title: "HUMIDITY",
                    icon: "humidity",
                    value: "\(Int(forecast.current?.humidity ?? 0))%"
                )
                
                WeatherInfoCard(
                    title: "FEELS LIKE",
                    icon: "thermometer",
                    value: "\(Int(forecast.current?.feelslike_c ?? 0))°"
                )
                
                WeatherInfoCard(
                    title: "PRESSURE",
                    icon: "gauge",
                    value: "\(Int(forecast.current?.pressure_mb ?? 0)) mb"
                )
            }
        }
    }
}

struct WeatherInfoCard: View {
    let title: String
    let icon: String
    let value: String
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                Text(title)
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(themeManager.textColor.opacity(0.6))
            
            Spacer()
            
            Text(value)
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(themeManager.textColor)
            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 150)
        .background(themeManager.isMorning ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
        .cornerRadius(20)
    }
}

//#Preview {
//    HomeBottomView(forecast: ForecastResponse(
//        location: Location(name: "San Francisco"),
//        current: CurrentForecast(temp_c: 22.0, condition: WeatherCondition(text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"), pressure_mb: 1013, humidity: 42, feelslike_c: 21.0, vis_km: 10.0),
//        forecast: nil
//    ))
//    .padding()
//    .background(Color.blue)
//    .environmentObject(ThemeManager())
//}

import SwiftUI

struct HomeTopView: View {
    let forecast: ForecastResponse
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        VStack(spacing: 5) {
            Text(forecast.location?.name ?? "Unknown Location")
                .font(.system(size: 34, weight: .semibold))
            
            HStack(alignment: .top) {
                Text("\(Int(forecast.current?.temp_c ?? 0))°")
                    .font(.system(size: 96, weight: .thin))
                
                if let iconUrlString = forecast.current?.condition?.icon,
                   let url = URL(string: "https:" + iconUrlString) {
                    AsyncImage(url: url) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .padding(.top, 20)
                }
            }
            
            Text(forecast.current?.condition?.text ?? "")
                .font(.system(size: 20, weight: .medium))
            
            if let today = forecast.forecast?.forecastday?.first?.day {
                Text("H:\(Int(today.maxtemp_c ?? 0))° L:\(Int(today.mintemp_c ?? 0))°")
                    .font(.system(size: 20, weight: .medium))
            }
        }
        .foregroundColor(themeManager.textColor)
        .padding(.vertical, 30)
    }
}

#Preview {
    HomeTopView(forecast: ForecastResponse(
        location: Location(name: "San Francisco"),
        current: CurrentForecast(temp_c: 22.0, condition: WeatherCondition(text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"), pressure_mb: 1013, humidity: 42, feelslike_c: 21.0, vis_km: 10.0),
        forecast: Forecast(forecastday: [
            ForecastDay(date: "2026-06-23", day: Day(maxtemp_c: 24.0, mintemp_c: 16.0, avgvis_km: 10.0, condition: WeatherCondition(text: "Clear", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png")), hour: nil)
        ])
    ))
    .background(Color.blue)
    .environmentObject(ThemeManager())
}

import SwiftUI

struct HomeTopView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        if let forecast = viewModel.forecastResponse {
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
}

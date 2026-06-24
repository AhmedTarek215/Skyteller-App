import SwiftUI

struct HourlyForecastView: View {
    let dayForecast: ForecastDay
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image(themeManager.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                            Text("BACK")
                                .font(.system(size: 12, weight: .bold))
                                .tracking(1.5)
                        }
                        .foregroundColor(themeManager.textColor.opacity(0.8))
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                .padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        if let hours = dayForecast.hour {
                            ForEach(Array(hours.enumerated()), id: \.offset) { index, hourly in
                                HStack {
                                    Text(formatTime(hourly.time))
                                        .frame(width: 80, alignment: .leading)
                                    
                                    Spacer()
                                    
                                    if let iconUrlString = hourly.condition?.icon,
                                       let url = URL(string: "https:" + iconUrlString) {
                                        AsyncImage(url: url) { image in
                                            image.resizable().scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 30, height: 30)
                                    } else {
                                        Image(systemName: "cloud.sun.fill")
                                            .frame(width: 30, height: 30)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(Int(hourly.temp_c ?? 0))°")
                                        .frame(width: 40, alignment: .trailing)
                                }
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(themeManager.textColor)
                                .padding(.vertical, 15)
                                
                                if index < hours.count - 1 {
                                    Divider()
                                        .background(themeManager.textColor.opacity(0.2))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }
            }
        }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
    
    func formatTime(_ timeString: String?) -> String {
        guard let timeString = timeString else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else { return timeString }
        
        formatter.dateFormat = "h a"
        return formatter.string(from: date)
    }
}

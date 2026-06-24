import SwiftUI

struct WeatherLayoutView: View {
    var forecast: ForecastResponse?
    var errorMessage: String?
    var showBackButton: Bool = false
    
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
            
            VStack(spacing: 0) {
                if showBackButton {
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
                }
                
                if let forecast = forecast {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 20) {
                            HomeTopView(forecast: forecast)
                            
                            HomeMiddleView(forecast: forecast)
                            
                            HomeBottomView(forecast: forecast)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                } else {
                    Spacer()
                    VStack {
                        ProgressView()
                            .tint(themeManager.textColor)
                            .scaleEffect(1.5)
                        
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(50)
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationBarHidden(showBackButton)
    }
}

import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        ZStack {
            // Background Image
            GeometryReader { geo in
                Image(themeManager.backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            
            if let forecast = viewModel.forecastResponse {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        HomeTopView(forecast: forecast)
                        
                        HomeMiddleView(forecast: forecast)
                        
                        HomeBottomView(forecast: forecast)
                    }
                    .padding(.horizontal, 20)
                    // Add bottom padding to account for the tab bar that will be there
                    .padding(.bottom, 100)
                }
            } else {
                VStack {
                    ProgressView()
                        .tint(themeManager.textColor)
                        .scaleEffect(1.5)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(50)
                    }
                }
            }
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}

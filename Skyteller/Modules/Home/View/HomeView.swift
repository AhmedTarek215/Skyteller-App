import SwiftUI
struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        NavigationView {
            WeatherLayoutView(forecast: viewModel.forecastResponse, errorMessage: viewModel.errorMessage)
        }
    }
}
#Preview {
    HomeView()
        .environmentObject(ThemeManager())
}

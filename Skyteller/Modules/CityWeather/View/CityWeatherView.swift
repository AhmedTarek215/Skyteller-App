import SwiftUI

struct CityWeatherView: View {
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    init(cityName: String) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(cityName: cityName))
    }
    
    var body: some View {
        WeatherLayoutView(
            viewModel: viewModel,
            showBackButton: true
        )
        .toolbar(.hidden, for: .tabBar)
    }
}

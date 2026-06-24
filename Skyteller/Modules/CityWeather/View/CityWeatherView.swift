import SwiftUI

struct CityWeatherView: View {
    @StateObject private var viewModel: CityWeatherViewModel
    @EnvironmentObject var themeManager: ThemeManager
    
    init(cityName: String) {
        _viewModel = StateObject(wrappedValue: CityWeatherViewModel(cityName: cityName))
    }
    
    var body: some View {
        WeatherLayoutView(
            forecast: viewModel.forecastResponse,
            errorMessage: viewModel.errorMessage,
            showBackButton: true
        )
    }
}

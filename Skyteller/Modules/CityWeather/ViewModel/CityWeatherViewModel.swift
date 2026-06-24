import Foundation
import Combine

class CityWeatherViewModel: ObservableObject {
    @Published var forecastResponse: ForecastResponse?
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    let cityName: String
    
    init(cityName: String, networkService: NetworkServiceProtocol = NetworkService()) {
        self.cityName = cityName
        self.networkService = networkService
        fetchWeatherForCity()
    }
    
    func fetchWeatherForCity() {
        networkService.fetchForecastByCity(cityName: cityName) { [weak self] response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                if let response = response {
                    self?.forecastResponse = response
                }
            }
        }
    }
}

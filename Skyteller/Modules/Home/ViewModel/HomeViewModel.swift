import Foundation

class HomeViewModel: ObservableObject {
    @Published var forecastResponse: ForecastResponse?
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchWeatherByLocation(lat: Double, long: Double) {
        networkService.fetchForecastByLocation(long: long, lat: lat) { [weak self] response, error in
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

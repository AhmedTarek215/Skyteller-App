import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var forecastResponse: ForecastResponse?
    @Published var errorMessage: String?
    
    private let networkService: NetworkServiceProtocol
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        setupLocation()
    }
    
    private func setupLocation() {
        locationManager.$location
            .compactMap { $0 }
            .first()
            .sink { [weak self] location in
                self?.fetchWeatherByLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude)
            }
            .store(in: &cancellables)
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

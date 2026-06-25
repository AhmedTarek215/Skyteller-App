import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var forecastResponse: ForecastResponse?
    @Published var errorMessage: String?
    @Published var showLocationAlert: Bool = false
    
    private let networkService: NetworkServiceProtocol
    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(cityName: String? = nil, networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        if let city = cityName {
            fetchWeatherForCity(city)
        } else {
            setupLocation()
        }
    }
    
    private func setupLocation() {
        locationManager.$location
            .compactMap { $0 }
            .first()
            .sink { [weak self] location in
                self?.fetchWeatherByLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude)
            }
            .store(in: &cancellables)
            
        locationManager.$isLocationDenied
            .receive(on: RunLoop.main)
            .sink { [weak self] denied in
                if denied {
                    self?.showLocationAlert = true
                }
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
    
    func fetchWeatherForCity(_ cityName: String) {
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

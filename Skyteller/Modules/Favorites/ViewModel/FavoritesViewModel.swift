import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteCities: [(name: String, country: String)] = []
    @Published var showRemoveAlert = false
    @Published var cityToRemove: String?
    
    private let localService: LocalServiceProtocol
    
    init(localService: LocalServiceProtocol? = nil) {
        if let localService = localService {
            self.localService = localService
        } else {
            self.localService = LocalService(context: PersistenceController.shared.container.viewContext)
        }
        loadFavorites()
    }
    
    func loadFavorites() {
        favoriteCities = localService.fetchAllCities()
    }
    
    func heartTapped(name: String) {
        cityToRemove = name
        showRemoveAlert = true
    }
    
    func confirmRemove() {
        if let city = cityToRemove {
            localService.deleteCity(name: city)
            cityToRemove = nil
            loadFavorites()
        }
    }
    
    func cancelRemove() {
        cityToRemove = nil
    }
}

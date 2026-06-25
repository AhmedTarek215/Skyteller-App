import Foundation
import CoreData

class ExploreViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showRemoveAlert = false
    @Published var cityToRemove: String?
    
    private let localService: LocalServiceProtocol
    
    // Static list of Egyptian cities
    let allCities: [(name: String, country: String)] = [
        ("Cairo", "Egypt"),
        ("Alexandria", "Egypt"),
        ("Giza", "Egypt"),
        ("Luxor", "Egypt"),
        ("Aswan", "Egypt"),
        ("Hurghada", "Egypt"),
        ("Sharm El-Sheikh", "Egypt"),
        ("Port Said", "Egypt"),
        ("Suez", "Egypt"),
        ("Mansoura", "Egypt"),
        ("Tanta", "Egypt"),
        ("Ismailia", "Egypt"),
        ("Faiyum", "Egypt"),
        ("Zagazig", "Egypt"),
        ("Damietta", "Egypt"),
        ("Minya", "Egypt"),
        ("Sohag", "Egypt"),
        ("Asyut", "Egypt"),
        ("Beni Suef", "Egypt"),
        ("Marsa Matruh", "Egypt")
    ]
    
    var filteredCities: [(name: String, country: String)] {
        if searchText.isEmpty {
            return allCities
        }
        return allCities.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
    }
    
    init(localService: LocalServiceProtocol? = nil) {
        if let localService = localService {
            self.localService = localService
        } else {
            self.localService = LocalService(context: PersistenceController.shared.container.viewContext)
        }
    }
    
    func isFavorite(name: String) -> Bool {
        return localService.isCitySaved(name: name)
    }
    
    func toggleFavorite(name: String, country: String) {
        if isFavorite(name: name) {
            // Show confirmation alert
            cityToRemove = name
            showRemoveAlert = true
        } else {
            // Add directly
            localService.addCity(name: name, country: country)
            objectWillChange.send()
        }
    }
    
    func confirmRemove() {
        if let city = cityToRemove {
            localService.deleteCity(name: city)
            cityToRemove = nil
            objectWillChange.send()
        }
    }
    
    func cancelRemove() {
        cityToRemove = nil
    }
}

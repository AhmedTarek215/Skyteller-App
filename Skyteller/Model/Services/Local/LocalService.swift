//
//  Local Services.swift
//  Skyteller
//
//  Created by Ahmed Tarek on 22/06/2026.
//

import Foundation
import CoreData

protocol LocalServiceProtocol {
    func addCity(name: String, country: String)
    func deleteCity(name: String)
    func isCitySaved(name: String) -> Bool
    func fetchAllCities() -> [(name: String, country: String)]
}

class LocalService : LocalServiceProtocol {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addCity(name: String, country: String) {
        guard !isCitySaved(name: name) else { return }
        
        let newCity = City(context: context)
        newCity.id = UUID()
        newCity.name = name
        newCity.country = country
        
        saveContext()
    }
    
    func deleteCity(name: String) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "name ==[c] %@", name)
        
        do {
            let fetchedCities = try context.fetch(fetchRequest)
            for city in fetchedCities {
                context.delete(city)
            }
            saveContext()
        } catch {
            print("Error deleting city: \(error.localizedDescription)")
        }
    }
    
    func isCitySaved(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name ==[c] %@", name)
        
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Error checking if city exists: \(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllCities() -> [(name: String, country: String)] {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        
        do {
            let cities = try context.fetch(fetchRequest)
            return cities.compactMap { city in
                guard let name = city.name, let country = city.country else { return nil }
                return (name: name, country: country)
            }
        } catch {
            print("Error fetching cities: \(error.localizedDescription)")
            return []
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data context: \(error.localizedDescription)")
            }
        }
    }
}

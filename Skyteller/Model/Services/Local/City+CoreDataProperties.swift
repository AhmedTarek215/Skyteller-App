//
//  City+CoreDataProperties.swift
//  Skyteller
//
//  Created by Ahmed Tarek on 22/06/2026.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var country: String?

}

extension City : Identifiable {

}

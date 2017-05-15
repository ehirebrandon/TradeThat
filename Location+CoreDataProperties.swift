//
//  Location+CoreDataProperties.swift
//  TradeThatApp
//
//  Created by Brandon on 4/14/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var city: String?
    @NSManaged var zip: String?
    @NSManaged var items: Items?

}

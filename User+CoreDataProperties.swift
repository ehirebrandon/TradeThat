//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var email: String?
    @NSManaged var feedback: String?
    @NSManaged var first: String?
    @NSManaged var last: String?
    @NSManaged var location: String?
    @NSManaged var items: NSSet?

}

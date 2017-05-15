//
//  Items+CoreDataProperties.swift
//  TradeThatApp
//
//  Created by Brandon on 4/15/16.
//  Copyright © 2016 Couchbase Training. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Items {

    @NSManaged var countID: NSNumber?
    @NSManaged var desc: String?
    @NSManaged var image: NSData?
    @NSManaged var sellFor: String?
    @NSManaged var sold: NSNumber?
    @NSManaged var subTitle: String?
    @NSManaged var title: String?
    @NSManaged var traded: NSNumber?
    @NSManaged var tradeFor: String?
    @NSManaged var userSellerFlag: NSNumber?
    @NSManaged var user: User?
    @NSManaged var map: Location?

}

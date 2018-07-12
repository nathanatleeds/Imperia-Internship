//
//  Photo+CoreDataProperties.swift
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var unique: String?
    @NSManaged public var whoTook: Photographer?

}

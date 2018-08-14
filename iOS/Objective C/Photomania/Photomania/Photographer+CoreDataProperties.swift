//
//  Photographer+CoreDataProperties.swift
//  Photomania
//
//  Created by slaviyana chervenkondeva on 11.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//
//

import Foundation
import CoreData


extension Photographer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photographer> {
        return NSFetchRequest<Photographer>(entityName: "Photographer")
    }

    @NSManaged public var name: String?
    @NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for photos
extension Photographer {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: Photo)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: Photo)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

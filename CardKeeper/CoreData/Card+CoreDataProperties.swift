//
//  Card+CoreDataProperties.swift
//  CardKeeper
//
//  Created by David Owen on 2/14/23.
//
//

import Foundation
import CoreData
import UIKit


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var backId: String?
    @NSManaged public var cardDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var dateReceived: Date?
    @NSManaged public var frontId: String?
    @NSManaged public var year: String?
    @NSManaged public var cardFrontImage: UIImage?
    @NSManaged public var cardBackImage: UIImage?
    @NSManaged public var family: Family?

}

extension Card : Identifiable {

}

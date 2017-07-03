//
//  Score+CoreDataProperties.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 03/07/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var value: Int32
    @NSManaged public var name: String?

}

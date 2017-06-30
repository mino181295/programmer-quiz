//
//  Score+CoreDataProperties.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 30/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score");
    }

    @NSManaged public var value: Int32
    @NSManaged public var date: NSDate?

}

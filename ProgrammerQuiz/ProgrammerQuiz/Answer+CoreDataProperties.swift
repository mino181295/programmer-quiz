//
//  Answer+CoreDataProperties.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer");
    }

    @NSManaged public var idAnswer: Int16
    @NSManaged public var text: String?
    @NSManaged public var isCorrect: Bool
    @NSManaged public var question: Question?

}

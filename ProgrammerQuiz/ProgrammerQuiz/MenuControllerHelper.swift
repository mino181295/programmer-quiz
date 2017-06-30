//
//  MenuControllerHelper.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 30/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension MenuViewController {
    
    public var delegate : AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    public var context : NSManagedObjectContext? {
        return delegate?.managedObjectContext
    }
    
    public func clearCoreData(){
        if (context != nil) {
            do {
                let entityNames = ["Question", "Answer"]
                
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try(context?.fetch(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects! {
                        context?.delete(object)
                    }
                }
                try(context?.save())
            } catch let err {
                print(err)
            }
        }
    }
    
    public func createData() {
        if (context != nil) {
            addQuestion(questionId: 1, questionText: "What is the programming language that was used to develop Minecraft?", questionScore: 10, correctAnswer: "Java", answer2: "C++", answer3: "Python")
            
            addQuestion(questionId: 2, questionText: "How many physical cores there are in a Intel Core i7?", questionScore: 20, correctAnswer: "4", answer2: "8", answer3: "16")
            
            addQuestion(questionId: 3, questionText: "What is the most popular OS for Samsung devices?", questionScore: 30, correctAnswer: "Android", answer2: "iOS", answer3: "Windows Phone")
            
            
            do {
                try(context?.save())
            } catch let err {
                print(err)
            }
        }
    }
    
    func addQuestion(questionId : Int16, questionText: String, questionScore: Int, correctAnswer: String, answer2: String, answer3: String){
        let question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
        question.idQuestion = questionId
        question.text = questionText
        question.scoreValue = Int32(questionScore)
        
        let answer11 = NSEntityDescription.insertNewObject(forEntityName: "Answer", into: context!) as! Answer
        answer11.idAnswer = questionId*10 + 1
        answer11.text = correctAnswer
        answer11.isCorrect = true
        answer11.question = question
        
        let answer12 = NSEntityDescription.insertNewObject(forEntityName: "Answer", into: context!) as! Answer
        answer12.idAnswer = questionId*10 + 2
        answer12.text = answer2
        answer12.isCorrect = false
        answer12.question = question
        
        let answer13 = NSEntityDescription.insertNewObject(forEntityName: "Answer", into: context!) as! Answer
        answer13.idAnswer = questionId*10 + 3
        answer13.text = answer3
        answer13.isCorrect = false
        answer13.question = question
        
        let answers : NSSet = [answer11, answer12, answer13]
        question.addToAnswers(answers)
    }
    
    public func loadQuestions() -> [Question]{
        if context != nil {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
            do {
                let questions = try(context?.fetch(fetchRequest)) as? [Question]
                return questions!
            } catch let err {
                print(err)
            }
        }
        
        return []
    }
    
    public func loadAnswers(forQuestion : Int16) -> [Answer]{
        if context != nil {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
            fetchRequest.predicate = NSPredicate(format: "idQuestion==%@", NSNumber(value: Int(forQuestion)))
            do {
                let question = try(context?.fetch(fetchRequest)) as! [Question]
                let answers = question[0].answers?.allObjects as! [Answer]
                return answers
            } catch let err {
                print(err)
            }
        }
        
        return []
    }
    
    public func entityIsEmpty(entity: String) -> Bool	{
        if context != nil {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            do {
                var count = 0
                try(count = (context?.count(for: request))!)
                if count == 0 {
                    return true
                } else {
                    return false
                }
            } catch let err {
                print(err)
            }
        }
        return true
    }
}

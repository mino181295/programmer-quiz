//
//  MenuControllerHelper.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 30/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

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
                let entityNames = ["Question", "Answer", "Score"]
                
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
            
            //Mobile Questions
            addQuestion(questionId: 1, questionText: "What is the programming language that was used to develop Minecraft?", questionScore: 10, correctAnswer: "Java", answer2: "C++", answer3: "Python")
            
            addQuestion(questionId: 20, questionText: "What is the latest Android development language that was introduced in 2017?", questionScore: 20, correctAnswer: "Kotlin", answer2: "Java", answer3: "Python")
            
            addQuestion(questionId: 2, questionText: "How many physical cores there are in a Intel Core i7?", questionScore: 30, correctAnswer: "4", answer2: "8", answer3: "16")
            
            addQuestion(questionId: 3, questionText: "What is the most popular OS for Samsung devices?", questionScore: 10, correctAnswer: "Android", answer2: "iOS", answer3: "Windows Phone")
            
            //Linux questions
            addQuestion(questionId: 4, questionText: "What command do you use to create Linux file systems?", questionScore: 50, correctAnswer: "mkfs", answer2: "mount", answer3: "fdisk")
            
            addQuestion(questionId: 5, questionText: "Which class network is used for a collection of a small number of networks with a large number of nodes?", questionScore: 30, correctAnswer: "Class A", answer2: "Class B", answer3: "Class C")
            
            addQuestion(questionId: 6, questionText: "What command is used to compare the files?", questionScore: 20, correctAnswer: "cmp", answer2: "comp", answer3: "ccp")
            
            //Database questions
            addQuestion(questionId: 7, questionText: "Which of the following is not a logical data-base structure?", questionScore: 35, correctAnswer: "Chain", answer2: "Tree", answer3: "Relational")
            
            addQuestion(questionId: 8, questionText: "Which command is used to remove a table from the database in SQL?", questionScore: 15, correctAnswer: "DROP TABLE", answer2: "DELETE TABLE", answer3: "ERASE TABLE")
            
            addQuestion(questionId: 9, questionText: "What is the abbreviation used for a software package that permits the users to create, retrieve and maintain records in a database?", questionScore: 10, correctAnswer: "DBMS", answer2: "EMMS", answer3: "DDL")
            
            //Networking questions
            addQuestion(questionId: 10, questionText: "What is the loopback address?", questionScore: 10, correctAnswer: "127.0.0.1", answer2: "192.168.1.1", answer3: "255.255.0.0")
            
            addQuestion(questionId: 11, questionText: "Which command-line tool is included with every Microsoft TCP/IP client?", questionScore: 30, correctAnswer: "PING", answer2: "DHCP", answer3: "NSLOOKUP")
            
            addQuestion(questionId: 12, questionText: "Which of the following summation operations is performed on the bits to check an error-detecting code?", questionScore: 20, correctAnswer: "Checksum", answer2: "Codec", answer3: "Codec")
            
            //Analysis questions
            addQuestion(questionId: 13, questionText: "The step-by-step instructions that solve a problem are called _____.", questionScore: 10, correctAnswer: "Algorithm", answer2: "Plan", answer3: "List")
            
            addQuestion(questionId: 14, questionText: "The first step in systems Development Life Cycle is", questionScore: 30, correctAnswer: "Preliminary investigation and analysis", answer2: "GUI Design", answer3: "Database Design")
            
            addQuestion(questionId: 15, questionText: "The first items defined for a new system are its", questionScore: 20, correctAnswer: "Outputs", answer2: "Inputs", answer3: "Functions")
            
            //C++ questions
            addQuestion(questionId: 16, questionText: "Assume that a program includes the short *agePtr = NULL; statement. The name of the pointer is _____", questionScore: 30, correctAnswer: "agePtr", answer2: "*agePtr", answer3: "&agePtr")
            
            addQuestion(questionId: 17, questionText: "The right shift operator is represented by the symbol", questionScore: 20, correctAnswer: ">>", answer2: "->", answer3: "RightShift()")
            
            addQuestion(questionId: 18, questionText: "If p and q are assigned the values 2 and 3 respectively then the statement p = q++", questionScore: 40, correctAnswer: "p=3", answer2: "p=4", answer3: "error")
            
            //Adds all the objects then saves the context
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

extension GameViewController {
    
    public var delegate : AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    public var context : NSManagedObjectContext? {
        return delegate?.managedObjectContext
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
}

extension FinalViewController {
    
    public var delegate : AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    public var context : NSManagedObjectContext? {
        return delegate?.managedObjectContext
    }
    //Saves high score in core data
    func saveHighScore(scoreValue: Int32, date: NSDate, name: String ){
        let score = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context!) as! Score
        score.value = scoreValue
        score.date = date
        score.name = name
            
        do {
            try(context?.save())
        } catch let err {
            print(err)
        }
    }
}

extension HighscoresCollectionViewController {
    
    public var delegate : AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    public var context : NSManagedObjectContext? {
        return delegate?.managedObjectContext
    }
    //Returns the ordered scores from core data
    public func loadHighScores() -> [Score]{
        if context != nil {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
            let sortDescriptor = NSSortDescriptor(key: "value", ascending: false)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            do {
                let scores = try(context?.fetch(fetchRequest)) as? [Score]
                return scores!
            } catch let err {
                print(err)
            }
        }
        return []
    }

}


//Add shuffle to arrays randomizing the order of the questions/answers..
extension Array {
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}

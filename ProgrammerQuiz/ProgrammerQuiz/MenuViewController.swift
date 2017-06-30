//
//  ViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var playButton: UIButton!
    @IBOutlet var highscoresButton: UIButton!
    @IBOutlet var creditsButton: UIButton!
    
    public var questions : [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let preferences = UserDefaults.standard
        let currentLevelKey = "CoreDataSetup"
        if !preferences.bool(forKey: currentLevelKey) {
            
            DispatchQueue.main.async {
                self.clearCoreData()
                self.createData()
            }
            
            preferences.set(true, forKey: currentLevelKey)
        }
        preferences.synchronize()
            
        if entityIsEmpty(entity: "Question") {
            clearCoreData()
            createData()
        } else {
            clearCoreData()
            createData()
        }
        
        questions = loadQuestions()
        questions.shuffle()
        
        for question in questions {
            print(question.text!)
        }
        
    
    }
        
    
    func setupButton(button : UIButton, cornerRadius : CGFloat, borderWidth : CGFloat, borderColor : UIColor){
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }

    func setupView() {
        setupButton(button: playButton, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
        setupButton(button: highscoresButton, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
        setupButton(button: creditsButton, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
    }
    
}
//Add shuffle to arrays randomizing the order of the questions/answers..
extension Array {
    mutating func shuffle() {
        guard count > 1 else {return}
        for shufflingIndex in (1..<count).reversed() {
            let randomIndex = Int(arc4random_uniform(UInt32(shufflingIndex)))
            swap(&self[shufflingIndex], &self[randomIndex])
        }
    }
}


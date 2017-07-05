//
//  GameViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answersLabels: [UIButton]!
    @IBOutlet var questionNumberLabel: UILabel!
    @IBOutlet var scoreValueLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var questions: [Question]!
    var currentAnswers: [Answer]!
    var currentQuestion : Question!
    var currentIndexes = [0,1,2]
    var score = 0
    var current = 0
    
    var timer : Timer!
    var remainingTime : Float!
    var defaultTime: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = loadQuestions()
        questions.shuffle()
        
        defaultTime = self.returnTimeFromSettings()
        remainingTime = Float(defaultTime)
        
        gameSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func goBackButton(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func answerOneTouchDown(_ sender: Any) {
        let answerReference = currentAnswers[currentIndexes[0]]
        if answerReference.isCorrect {
            correct()
        } else {
            lose()
        }
    }
    @IBAction func answerTwoTouchDown(_ sender: Any) {
        let answerReference = currentAnswers[currentIndexes[1]]
        if answerReference.isCorrect {
            correct()
        } else {
            lose()
        }
    }
    @IBAction func answerThreeTouchDown(_ sender: Any) {
        let answerReference = currentAnswers[currentIndexes[2]]
        if answerReference.isCorrect {
            correct()
        } else {
            lose()
        }
    }
    
    func gameSetup(){
        setupNewQuestion(index: 0)
        scoreValueLabel.text = String(score)
    }
    
    func setupNewQuestion(index : Int){
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
        currentQuestion = questions[index]
        setQuestion(question: currentQuestion!)
        
        currentAnswers = loadAnswers(forQuestion: (currentQuestion?.idQuestion)!)
        setAnswers(answers: currentAnswers)
        
        questionNumberLabel.text = String(current+1)
        
        current += 1
        
        if current > questions.count {
            print("End of questions")
        }
    }
    
    func setQuestion(question : Question){
        questionLabel.text = question.text!
    }
    
    //answerLabel[i] = currentAnswer[index[i]]
    func setAnswers(answers : [Answer]){
        currentIndexes.shuffle()
        for i in 0...currentAnswers.count-1 {
            //print("Put in button" + (i+1) + "answer number " + (currentIndexes[i]+1))
            answersLabels[i].setTitle(currentAnswers[currentIndexes[i]].text!, for: .normal)
        }
    }
    
    func correct(){
        timer.invalidate()
        remainingTime = Float(defaultTime)
        
        score += Int(currentQuestion.scoreValue)
        scoreValueLabel.text = String(score)
        
        if (current < questions.count) {
            setupNewQuestion(index: current)
        } else {
            presentFinalViewController(isWin: true)
        }
    }
    
    func lose(){
        timer.invalidate()
        presentFinalViewController(isWin: false)        
    }
    
    func updateTimer(){
        remainingTime = remainingTime - 0.01
        if remainingTime <= 0 {
            lose()
        } else {
            timeLabel.text = String.localizedStringWithFormat("%.2f", remainingTime)
        }
    }
    
    func presentFinalViewController(isWin : Bool){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Final") as! FinalViewController
        
        controller.label = isWin ? "YOU WON" : "YOU LOST"
        controller.score = score
        
        self.present(controller, animated: true, completion: nil)
        
        let _ = self.navigationController?.popToRootViewController(animated: false)
    }
    
    func returnTimeFromSettings() -> Int {
        let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("settings.data")
        let object = NSKeyedUnarchiver.unarchiveObject(withFile: fileUrl.path)
        
        if let value = object as? Float {
            return Int(value.rounded(.down))
        } else {
            return 15
        }
    }
    
}

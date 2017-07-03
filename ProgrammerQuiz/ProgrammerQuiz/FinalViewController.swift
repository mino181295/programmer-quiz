//
//  FinalViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 30/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit
import CoreData

class FinalViewController: UIViewController {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var quitButton: UIButton!
    
    public var score : Int!
    public var label : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 5
        quitButton.layer.cornerRadius = 5
        
        resultLabel.font = UIFont(name: resultLabel.font.fontName, size: 30)
        resultLabel.textAlignment = .center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resultLabel.text = label
        scoreLabel.text = String(score)
    }

    @IBAction func saveTouchDown(_ sender: Any) {
        //Save
        goToRoot()
        saveHighScore(scoreValue: Int32(score!), date: NSDate())
    }

    @IBAction func quitTouchDown(_ sender: Any) {
        goToRoot()
    }
    
    
    func goToRoot() {
        self.dismiss(animated: true, completion: {})
    }
}

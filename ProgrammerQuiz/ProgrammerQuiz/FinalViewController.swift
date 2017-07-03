//
//  FinalViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 30/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit
import CoreData

class FinalViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var quitButton: UIButton!
    @IBOutlet var nameText: UITextField!
    
    public var score : Int!
    public var label : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 5
        quitButton.layer.cornerRadius = 5
        
        resultLabel.font = UIFont(name: resultLabel.font.fontName, size: 30)
        resultLabel.textAlignment = .center
        
        nameText.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resultLabel.text = label
        scoreLabel.text = String(score)
    }

    @IBAction func saveTouchDown(_ sender: Any) {
        //Save
        let name = nameText.text?.trimmingCharacters(in: .whitespaces)
        
        if (nameText.text != ""){
            goToRoot()
            saveHighScore(scoreValue: Int32(score!), date: NSDate(),name: name!)
        } else {
            let alert = UIAlertController(title: "Name warning", message: "You didn't put the name for the highscore", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func quitTouchDown(_ sender: Any) {
        goToRoot()
    }
    
    
    func goToRoot() {
        self.dismiss(animated: true, completion: {})
    }
}

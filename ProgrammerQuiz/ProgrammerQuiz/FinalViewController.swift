//
//  FinalViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 30/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    public var score : Int!
    public var label : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resultLabel.text = label
        scoreLabel.text = String(score)

    }

    @IBAction func saveTouchDown(_ sender: Any) {
        
    }


}

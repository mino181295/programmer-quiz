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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupButton(button : UIButton, cornerRadius : CGFloat, borderWidth : CGFloat, borderColor : UIColor){
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
    }
    
    func setupView() {
        setupButton(button: playButton, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
        setupButton(button: highscoresButton, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
        setupButton(button: creditsButton, cornerRadius: 5, borderWidth: 1, borderColor: UIColor.lightGray)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }

}


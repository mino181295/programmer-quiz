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

    }
        
    
    func setupButton(button : UIButton, cornerRadius : CGFloat){
        button.layer.cornerRadius = cornerRadius
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }

    func setupView() {
        setupButton(button: playButton, cornerRadius: 5)
        setupButton(button: highscoresButton, cornerRadius: 5)
        setupButton(button: creditsButton, cornerRadius: 5)
    }
    
}


//
//  ViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    //Storyboard Outlets
    @IBOutlet var playButton: UIButton!
    @IBOutlet var highscoresButton: UIButton!
    @IBOutlet var creditsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupView()
        //Access to shared preferences to decide if coredata has to setup
        let preferences = UserDefaults.standard
        let currentLevelKey = "CoreDataSetup"
        if !preferences.bool(forKey: currentLevelKey) {
            //Uses a dispatcher thread to create the business logic
            DispatchQueue.main.async {
                self.clearCoreData()
                self.createData()
            }
            preferences.set(true, forKey: currentLevelKey)
        }
        preferences.synchronize()
        //Logic ready to setup
    }
    //Button creation
    func setupButton(button : UIButton, cornerRadius : CGFloat){
        button.layer.cornerRadius = cornerRadius
    }
    //Setup back navigation icon name to "Back" instead of the name
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    //Setup of the view
    func setupView() {
        setupButton(button: playButton, cornerRadius: 5)
        setupButton(button: highscoresButton, cornerRadius: 5)
        setupButton(button: creditsButton, cornerRadius: 5)
    }    
}


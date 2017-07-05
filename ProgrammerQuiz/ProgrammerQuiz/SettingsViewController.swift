//
//  SettingsViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 05/07/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("settings.data")

    @IBOutlet var timeSlider: UISlider!
    @IBOutlet var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(format: "%.0f", timeSlider.value)
    }
    
    @IBAction func onSliderChange(_ sender: Any) {
        let roundedValue = timeSlider.value.rounded(.down)
        timeLabel.text = String(format: "%.0f", roundedValue)
    }

    @IBAction func savePressed(_ sender: Any) {
        NSKeyedArchiver.archiveRootObject(timeSlider.value, toFile: fileUrl.path)
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }

}

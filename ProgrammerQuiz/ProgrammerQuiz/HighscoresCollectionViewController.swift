//
//  HighscoresCollectionViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "scoreCell"

//Collection view to store the scores
class ScoreCell: UICollectionViewCell {
    
    @IBOutlet var ordinalLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var dateValue: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    func convertDate(data: Date) -> String {
        
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: data)
        let date2 = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.hour], from: date1, to: date2)
        let formatter = DateFormatter()
        let hours = components.hour!
        
        if (hours < 6) {
            formatter.dateFormat = "HH:mm"
        } else {
            formatter.dateFormat = "dd/MM/yy"
        }
        return formatter.string(from: data)
    }
}

class HighscoresCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //List of the scores
    var scores : [Score]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gets the scores from coredata
        scores = self.loadHighScores()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scores!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScoreCell
        
        let i = indexPath.row
        
        if (i%2 == 0) {
            cell.backgroundColor = UIColor.init(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.white
        }
    
        cell.ordinalLabel.text = String(describing: i + 1) + "."
        cell.scoreLabel.text = String(scores[i].value)
        cell.dateValue.text = cell.convertDate(data: scores[i].date as! Date)
        cell.nameLabel.text = scores[i].name
    
        return cell
    }
}


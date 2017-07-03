//
//  HighscoresCollectionViewController.swift
//  ProgrammerQuiz
//
//  Created by Matteo Minardi on 27/06/17.
//  Copyright © 2017 Matteo Minardi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "scoreCell"


class ScoreCell: UICollectionViewCell {
    
    @IBOutlet var ordinalLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var dateValue: UILabel!
    
    func convertDate(data: Date) -> String {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        
        return formatter.string(from: data)
    }
}

class HighscoresCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var scores : [Score]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
        return cell
    }

}


//
//  LapCell.swift
//  Utilities
//
//  Created by Wyatt Allen on 12/15/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class LapCell: UITableViewCell {
    
    @IBOutlet weak var lapSecondsLabel: UILabel!
    @IBOutlet weak var lapMinutesLabel: UILabel!
    @IBOutlet weak var lapMillisecondsLabel: UILabel!
    @IBOutlet weak var lapNumberLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lapSecondsLabel.text = nil
        lapMinutesLabel.text = nil
        lapMillisecondsLabel.text = nil
    }
    
    func configure(time: Double, number: Int) {
        
        let numSeconds = Int(time) % 60
        let numMinutes = Int(time / 60) % 60
        let numMilliseconds = Int(time * 100) % 100
        lapNumberLabel.text = "Lap \(number + 1)"
        lapMinutesLabel.text = String(format: "%02d", numMinutes )
        lapSecondsLabel.text = String(format: "%02d", numSeconds)
        lapMillisecondsLabel.text = String(format: "%02d", numMilliseconds)
    }
    
}

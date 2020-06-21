//
//  GoalCell.swift
//  GoalPost
//
//  Created by Abu Salleeiihh on 3/17/20.
//  Copyright © 2020 Abu Salleeiihh. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var complitionView: UIView!
    
    func configureCell(goal: Goal)  {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType!
        self.goalProgressLbl.text = String(describing: goal.goalprogress)
        if goal.goalprogress == goal.goalCompletionValue {
            self.complitionView.isHidden = false
        }else {
            self.complitionView.isHidden = true
        }
    }
    
}

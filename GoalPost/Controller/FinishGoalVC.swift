//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Abu Salleeiihh on 3/18/20.
//  Copyright © 2020 Abu Salleeiihh. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {
    
    @IBOutlet weak var crateGoalBtn: UIButton!
    @IBOutlet weak var pointsTextFaild: UITextField!
    
    var goalDescription :String!
    var goalType : GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        crateGoalBtn.bindToKeyboard()
        pointsTextFaild.layer.borderWidth = 0
      
    }
    
    
    @IBAction func crateGoalWasPressd(_ sender: Any) {
        if pointsTextFaild.text != "" {
            self.save { (complete) in
                if complete{
                    let alerControl = UIAlertController(title: "Welcome", message: "Your Goal has been successfully saved", preferredStyle:.alert)
                    let okAction = UIAlertAction(title: "Done", style: .cancel) { (UIAlertAction) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    alerControl.addAction(okAction)
                    self.present(alerControl, animated: true)
                    
                }
            }
        }
    
    }
    
    @IBAction func backBtnWasPressd(_ sender: Any) {
        dismissDetail()
    }
    
    func save(complation: (_ finished: Bool) -> () ){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.map { $0.rawValue }
        goal.goalCompletionValue = Int32(pointsTextFaild.text!)!
        goal.goalprogress = Int32(0)
        
        do {
            print("savd")
            try managedContext.save()
            complation(true)
        } catch  {
            print(error.localizedDescription)
            complation(false)
        }
        
    }
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
   
}

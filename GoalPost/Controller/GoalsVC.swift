//
//  GoalsVC.swift
//  GoalPost
//
//  Created by Abu Salleeiihh on 3/17/20.
//  Copyright © 2020 Abu Salleeiihh. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
let context = appDelegate?.persistentContainer.viewContext


class GoalsVC: UIViewController {
    @IBOutlet weak var tableViewGoal: UITableView!
    
    var goals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewGoal.delegate = self
        tableViewGoal.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoraDate()
        tableViewGoal.reloadData()
       
    }
    func fetchCoraDate() {
        self.fetch { (complete) in
                   if complete {
                       if goals.count >= 1 {
                           tableViewGoal.isHidden = false

                       }else{
                           tableViewGoal.isHidden = true
                       }
                   }
               }
    }
    
    @IBAction func addGoalPost(_ sender: Any) {
        guard let createGoalVc = storyboard?.instantiateViewController(identifier: "CreateGoalVC") else { return  }
        presentDetail(createGoalVc)
    }
    

}
extension GoalsVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "ADD 1") { (action, view, nil) in
            self.setprogress(atindexpath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            self.removeGoal(atindexpath: indexPath)
            self.fetchCoraDate()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        addAction.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
        return UISwipeActionsConfiguration(actions: [deleteAction, addAction])
    }
    
}

extension GoalsVC {
    
    func setprogress(atindexpath indexpath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let chosenGoal = goals[indexpath.row]
        if chosenGoal.goalprogress < chosenGoal.goalCompletionValue {
            chosenGoal.goalprogress = chosenGoal.goalprogress + 1
        }else {
            
        }
        do {
            try managedContext.save()
            print("successfully set progress")
            self.tableViewGoal.reloadData()
        } catch  {
            debugPrint("could not set: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atindexpath indexpath: IndexPath)  {
      guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let commit = self.goals[indexpath.row]
        managedContext.delete(commit)
        
        do {
            try managedContext.save()
            self.tableViewGoal.reloadData()
            print("you goal removed")
        } catch  {
          debugPrint("could not delete: \(error.localizedDescription)")
        }
    }
    
    
    
    
 func fetch(completion: (_ complete: Bool ) -> () )  {
      guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
     
    let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
    
    do {
        goals = try managedContext.fetch(fetchRequest)
        print("successfully fetched data")
        completion(true)
    } catch  {
        debugPrint("could not fetch: \(error.localizedDescription)")
        completion(false)
    }
    
 }
}



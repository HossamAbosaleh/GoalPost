//
//  UIViewControllerExt.swift
//  GoalPost
//
//  Created by Abu Salleeiihh on 3/18/20.
//  Copyright © 2020 Abu Salleeiihh. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentDetail(_ viewcontrollerPressent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewcontrollerPressent, animated: false, completion: nil)
        
    }
    
    func presentSecondDetail(_ viewcontrollerPressent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let presentedViewController = presentedViewController else { return }
        presentedViewController.dismiss(animated: false, completion: {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewcontrollerPressent, animated: false, completion: nil)
        })
        
    }
    
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
        
    }
    
    
}


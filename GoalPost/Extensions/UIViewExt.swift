//
//  UIViewExt.swift
//  GoalPost
//
//  Created by Abu Salleeiihh on 3/18/20.
//  Copyright © 2020 Abu Salleeiihh. All rights reserved.
//

import UIKit

extension UIView {
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }

    @objc func keyboardWillShow(_ notification: NSNotification){
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let startingFram = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue ).cgRectValue
        let endingFram = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endingFram.origin.y - startingFram.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
        
        
    }
    
}

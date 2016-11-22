//
//  UtilityMethods.swift
//  QuandooTest
//
//  Created by Midhun P Mathew on 11/6/16.
//  Copyright © 2016 Midhun P Mathew. All rights reserved.
//

import Foundation
import UIKit

func currentRootViewController() -> UIViewController {
    return (UIApplication.shared.keyWindow?.rootViewController)!
}
func dispatchOnMainQueue(closure: @escaping () -> Void) {
    
    DispatchQueue.main.async {
        closure()
    }
    
}
func dispatchBackgroundQueue(closure: @escaping () -> Void) {
    DispatchQueue.global().async {
        closure()
    }
    
}

func showAlert(titel:String,messege:String){
    let alertController = UIAlertController(title: titel, message: messege, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    currentRootViewController().present(alertController, animated: true, completion: nil)
}

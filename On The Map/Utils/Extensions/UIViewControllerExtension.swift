//
//  UIViewControllerExtension.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/16/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyBoardOnTapOutside() {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
       tapGesture.cancelsTouchesInView = false
       view.addGestureRecognizer(tapGesture)
     }
    
     @objc func hideKeyboard() {
       view.endEditing(true)
     }
    
    func showAlertError(text: String) {
        let alert = UIAlertController(title: "Oops...", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

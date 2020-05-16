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
}

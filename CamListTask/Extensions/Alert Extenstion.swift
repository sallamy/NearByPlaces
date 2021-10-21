//
//  Alert Extenstion.swift
//  Task
//
//  Created by mohamed salah on 9/3/21.
//

import Foundation
import  UIKit

extension UIAlertController {
    class func show(_ message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        controller.present(alert, animated: true) {
            
        }
    }
}

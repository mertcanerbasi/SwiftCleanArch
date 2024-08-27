//
//  AlertHelper.swift
//  SwiftCleanArch
//
//  Created by Mertcan Erbaşı on 27.08.2024.
//

import UIKit

class AlertHelper {
    static func showAlert(on viewController: UIViewController, title: String, message: String, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}

//
//  UIHelperFunctions.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/23.
//

import UIKit

class UIHelperFunctions{
    
    static func showAlertMessage(message: String, start: (_ alert: UIAlertController)-> Void) {
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(action)
        start(alert)
    }
}

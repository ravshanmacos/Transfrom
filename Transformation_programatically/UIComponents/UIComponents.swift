//
//  CustomButton.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit

class UIComponents{
    
    static let shared = UIComponents()
    private let baseFontSize:CGFloat = 16
    private init(){}
    func createButton(type: ButtonType, image: UIImage? = nil, text: String? = nil,
                              state isEnabled: Bool = true
    )->UIButton{
        let button = UIButton()
        if let image {button.setImage(image, for: .normal)}
        if let text {button.setTitle(text, for: .normal)}
        
        switch type {
        case .filled:
            button.backgroundColor = UIColor.systemBlue
            button.tintColor = .white
        case .outlined:
            button.layer.borderWidth = 1
            button.tintColor = UIColor.systemBlue
        }
        button.isEnabled = isEnabled
        button.layer.cornerRadius = 5
        return button
    }
    
    func createButton(text: String, state isEnabled: Bool = true)->UIButton{
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = isEnabled
        return button
    }
}

extension UIComponents{
    enum ButtonType{
        case filled
        case outlined
    }
    enum ButtonColor{
        case dark
        case light
    }
}

//
//  CustomButton.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit
import TinyConstraints

class UIComponents{
    
    static let shared = UIComponents()
    private let baseSize: CGFloat = Constants.baseSize
    private let baseFontSize:CGFloat = Constants.baseFontSize
    private init(){}
    
    func createLabel(type: LabelType = .medium,with text: String, centered: Bool = false)->UILabel{
        let label = UILabel()
        if centered {label.textAlignment = .center}
        label.text = text
        label.textColor = .darkGray
        switch type {
        case .extraLarge:
            label.font = UIFont.systemFont(ofSize: baseFontSize * 3, weight: .bold)
        case .large:
            label.font = UIFont.systemFont(ofSize: baseFontSize * 1.5, weight: .medium)
        case .medium:
            label.font = UIFont.systemFont(ofSize: baseFontSize, weight: .medium)
        case .small:
            label.textColor = .lightGray
            label.font = UIFont.systemFont(ofSize: baseFontSize * 0.8, weight: .regular)
        }
        return label
    }
    
    func createHeaderTitle(title: String)-> UILabel{
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: baseFontSize, weight: .semibold)
        titleLabel.textColor = UIColor.darkGray
        return titleLabel
    }
    
    func createTexField(placeholder: String = "", text: String = "")->UITextField{
        let textfield = UITextField()
        if placeholder != "" {textfield.placeholder = placeholder}
        if text != "" {textfield.text = text}
        textfield.borderStyle = .roundedRect
        return textfield
    }
 
    func createButton(text: String, state isEnabled: Bool = true)-> UIButton{
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.systemBlue
        button.isEnabled = isEnabled
        return button
    }
    
    func createCicularButton(image: UIImage)->UIButton{
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        return button
    }
    
    func createStack(axis: NSLayoutConstraint.Axis = .horizontal,
                     spacing: CGFloat = 0,
                     views: [UIView]? = nil,
                     fillEqually: Bool = false
    )->UIStackView{
        var stack = UIStackView()
        if let views{
            stack = UIStackView(arrangedSubviews: views)
        }
        if fillEqually {stack.distribution = .fillEqually}
        stack.axis = axis
        stack.spacing = spacing
        return stack
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
    enum LabelType{
        case extraLarge
        case large
        case medium
        case small
    }
}

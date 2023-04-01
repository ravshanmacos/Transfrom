//
//  UIStackView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit

extension UIStackView{
    func addArrangedSubviews(_ views: [UIView]){
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}

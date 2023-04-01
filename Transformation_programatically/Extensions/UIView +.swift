//
//  UIView +.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/01.
//

import UIKit

extension UIView{
    func addSubviews(_ views: [UIView]){
        views.forEach { view in
            addSubview(view)
        }
    }
}

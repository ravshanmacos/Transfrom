//
//  WorkoutPartsCell.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/04.
//

import UIKit

class EditWorkoutPartsCell: UITableViewCell{
    
    private let components = UIComponents.shared
    private var baseFontSize: CGFloat{
        return Constants.baseFontSize
    }
    lazy var title: UILabel = {
        return components.createLabel(type: .medium, with: "")
    }()
    
    lazy var secondaryTitle: UILabel = {
        return components.createLabel(type: .small, with: "")
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        let vrStack = components.createStack(axis: .vertical, views: [title, secondaryTitle])
        vrStack.layoutMargins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        vrStack.isLayoutMarginsRelativeArrangement = true
        addSubview(vrStack)
        vrStack.edgesToSuperview()
    }
    
    private func setupConstraints(){}
}


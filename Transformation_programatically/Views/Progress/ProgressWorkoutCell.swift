//
//  ProgressWorkoutCell.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import UIKit

class ProgressWorkoutCell: UITableViewCell{
    
    private var baseFontSize: CGFloat{
        return Constants.baseFontSize
    }
    
    lazy var title: UILabel = {
        return createLabel(type: .medium)
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
        addSubview(title)
        title.centerYToSuperview()
        title.leftToSuperview(offset: 20)
    }
    
    private func setupConstraints(){
        
    }
}

extension ProgressWorkoutCell{
    private func createLabel(type:LabelType)-> UILabel{
       let label = UILabel()
       
        switch type {
        case .large:
            label.font = UIFont.systemFont(ofSize: baseFontSize*1.5, weight: .bold)
        case .medium:
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: baseFontSize, weight: .medium)
        case .small:
            label.textColor = .darkGray
            label.font = UIFont.systemFont(ofSize: baseFontSize*0.7, weight: .regular)
            
        }
       return label
    }
}

//
//  ProgressWorkoutCell.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import UIKit

class ProgressWorkoutCell: UITableViewCell{
    
    private let components = UIComponents.shared
    private var baseFontSize: CGFloat{
        return Constants.baseFontSize
    }
    
    lazy var title: UILabel = {
        return components.createLabel(with: "")
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

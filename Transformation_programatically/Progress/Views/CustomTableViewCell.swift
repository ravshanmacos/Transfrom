//
//  ProgressWorkoutCell.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import UIKit

class CustomTableViewCell: UITableViewCell{
    
    private let components = UIComponents.shared
    private var baseFontSize: CGFloat{
        return Constants.baseFontSize
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(title)
        title.centerYToSuperview()
        title.leftToSuperview(offset: 20)
    }
}

extension CustomTableViewCell{
    func configureCellUI(_ color: UIColor?){
        self.backgroundColor = color
        self.tintColor = .white
        self.accessoryView = UIImageView(image: .chevronImage)
    }
}

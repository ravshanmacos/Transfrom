//
//  ImageCollectionViewCell.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/07.
//

import UIKit
import TinyConstraints

class ImageCollectionViewCell: UICollectionViewCell{
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(imageView)
        imageView.edgesToSuperview()
    }
}

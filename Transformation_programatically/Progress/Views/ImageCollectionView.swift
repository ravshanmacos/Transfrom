//
//  ImageCollectionView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import UIKit
import TinyConstraints

class ImageCollectionView: UIView{
    
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView
    private let reuseIdentifier = "imageCollectionViewCell"
    private var images: [UIImage] = []
    
    override init(frame: CGRect) {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupCollectionView()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ images: [UIImage]) {
        self.init(frame: CGRect.zero)
        self.images = images
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCollectionViewCell")
    }
    
    private func setupViews(){
        addSubview(collectionView)
        collectionView.edgesToSuperview(insets: TinyEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) ,usingSafeArea: true)
    }
    
}

//MARK: - UICollectionView DataSource

extension ImageCollectionView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                                                                                            as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}

extension ImageCollectionView: UICollectionViewDelegate{}

extension ImageCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth / 3, height: collectionWidth / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


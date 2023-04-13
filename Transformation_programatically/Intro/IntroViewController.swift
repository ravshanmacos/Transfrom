//
//  ViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/01.
//

import UIKit
import Combine

class IntroViewController: UIViewController {
    //MARK: - Properties
    
    //private UI
    private let uiComponents = UIComponents.shared
    private lazy var baseSize = Constants.baseSize
    private lazy var imageView = configureImageView()
    private lazy var descriptionLabel: UILabel = configureDescriptionLabel()
    private lazy var nextButton: UIButton = configureNextBtn()
    var viewModel: IntroViewModel?
    
    //MARK: - LifeCycle Methods
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .bckColor_1
        let buttonsStack = uiComponents.createStack()
        
        buttonsStack.addArrangedSubview(nextButton)
        view.addSubviews([imageView, descriptionLabel, buttonsStack])
        
        imageView.centerInSuperview()
        imageView.width(250)
        imageView.height(250)
        
        descriptionLabel.leftToSuperview(offset: 20)
        descriptionLabel.rightToSuperview(offset: -20)
        descriptionLabel.topToBottom(of: imageView, offset: 20)
        
        buttonsStack.leftToSuperview(offset: baseSize * 2)
        buttonsStack.rightToSuperview(offset: baseSize * -2)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: baseSize * -2, usingSafeArea: true)
    }
    
    @objc func nextBtnTapped(){
        guard let viewModel else {return}
        viewModel.isNextBtnTapped = true
    }
}

//MARK: - configure Layout
extension IntroViewController{
    private func configureImageView()->UIImageView{
        let imageView = UIImageView(image: .pandaBulkingImage)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func configureDescriptionLabel()->UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: "textColor_1")
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.text = "Let's burn the fat and be forever in good shape"
        return label
    }
    
    private func configureNextBtn()->UIButton{
        let btn = uiComponents.createButton(text: "Let's Start")
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        return btn
    }
}


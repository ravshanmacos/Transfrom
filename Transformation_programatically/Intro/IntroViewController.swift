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
    private lazy var nextButton: UIButton = configureNextBtn()
    var viewModel: IntroViewModel?
    
    //MARK: - LifeCycle Methods
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        let buttonsStack = uiComponents.createStack()
        
        buttonsStack.addArrangedSubview(nextButton)
        view.addSubview(buttonsStack)
        
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
    private func configureNextBtn()->UIButton{
        let btn = uiComponents.createButton(text: "Next")
        
        btn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        return btn
    }
}






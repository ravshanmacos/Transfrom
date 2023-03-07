//
//  ViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/01.
//

import UIKit

class MainViewController: UIViewController {
    
    private let components = UIComponents.shared
    
    private lazy var nextButton: UIButton = {
        let btn = components.createButton(text: "Next")
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    var isTapped: (()->Void)?
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews(){
        view.backgroundColor = .white
        let buttonsStack = components.createStack()
        
        buttonsStack.addArrangedSubview(nextButton)
        view.addSubview(buttonsStack)
        
        buttonsStack.leftToSuperview(offset: 20)
        buttonsStack.rightToSuperview(offset: -20)
        buttonsStack.height(50)
        buttonsStack.bottomToSuperview(offset: -Constants.baseSize * 2, usingSafeArea: true)
    }

    private func setupConstraints(){}

    @objc func buttonTapped(){
        if let isTapped{
            isTapped()
        }
    }

}






//
//  ViewController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/01.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    //MARK: - Properties
    
    //private UI
    private let uiComponents = UIComponents.shared
    private lazy var baseSize = Constants.baseSize
    private lazy var nextButton: UIButton = {
        let btn = uiComponents.createButton(text: "Next")
        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    //optionals
    weak var coordinator: MainCoordinator?
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Actions
    @objc func buttonTapped(){
        coordinator?.openTabbar()
    }

}

//MARK: - UIHelper Functions
extension MainViewController{
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
}






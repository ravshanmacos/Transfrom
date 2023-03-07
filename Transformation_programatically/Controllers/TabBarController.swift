//
//  TabBarController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/03.
//

import UIKit

class TabBarController: UITabBarController {

    private let runImageString = "figure.run.circle"
    private let chartImageString = "chart.bar.doc.horizontal"
    private let plusImageString = "plus.circle"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarControllers()
        
    }
    
    private func setupTabbarControllers(){
        //view.backgroundColor = .white
        let workoutCategoryVC = WorkoutCategoryController()
        let progressVC = ProgressWorkoutController()
        let createVC = CreateWorkoutController()
        viewControllers = [workoutCategoryVC,createVC, progressVC]
        
        let workoutVcImage = UIImage.init(systemName: runImageString)
        let workoutVcSelectedState = UIImage.init(systemName: "\(runImageString).fill")
        workoutCategoryVC.tabBarItem = UITabBarItem(title: "Start", image: workoutVcImage, selectedImage: workoutVcSelectedState)
        
        let progressVCImage = UIImage.init(systemName: chartImageString)
        let progressVCSelectedState = UIImage.init(systemName: "\(chartImageString).fill")
        progressVC.tabBarItem = UITabBarItem(title: "Progress", image: progressVCImage, selectedImage: progressVCSelectedState)
        
        let createVCImage = UIImage.init(systemName: plusImageString)
        let createVCSelectedState = UIImage.init(systemName: "\(plusImageString).fill")
        createVC.tabBarItem = UITabBarItem(title: "Create", image: createVCImage, selectedImage: createVCSelectedState)
    }

}

//
//  AnalysisCoordinator.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/15.
//

import UIKit

class AnalysisCoordinator: BaseCoordinator{
    //MARK: - Properties
    var coreDataManager: CoreDataManager?
    var workout: Workout?
    
    //MARK: - Actions
    override func start() {
        guard let workout else {return}
        let viewModel = AnalysisViewModel()
        viewModel.coreDataManager = coreDataManager
        viewModel.workout = workout
        
        let vc = AnalysisController()
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}

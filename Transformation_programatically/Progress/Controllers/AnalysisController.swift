//
//  AnalysisController.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import UIKit
import TinyConstraints

class AnalysisController: UIViewController {
    
    private let components = UIComponents.shared
    let cldHelper = CalendarHelper.shared
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    
    private var baseFontSize: CGFloat{
        return Constants.baseFontSize
    }
    
    private lazy var headerTitle: UILabel = {
        return components.createHeaderTitle(title: "Images")
    }()
    
    private lazy var dateTitle: String = {
        let date = Date()
        let monthName = cldHelper.getMonthName(date: date)
        let yearName = cldHelper.getYearName(date: date)
        let dayOfMonth = cldHelper.getDayOfMonth(date: date)
       return "Today, \(monthName) \(dayOfMonth), \(yearName)"
    }()
    
    private lazy var weeklyCalendarView: UIView = {
       return WeeklyCalendarView()
    }()
    
    private lazy var circlularProgressView: UIView = {
        let view = CircularProgressView()
        view.lineWidth = 17.0
        view.progress = 0.7
       return view
    }()
    
    private lazy var imageCollectionView: UIView = {
       return ImageCollectionView()
    }()
    weak var coordinator: AnalysisCoordinator?
    var workout: Workout?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = dateTitle
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        [weeklyCalendarView, circlularProgressView, headerTitle, imageCollectionView].forEach{view.addSubview($0)}
    }
    
    private func setupConstraints(){
        weeklyCalendarView.topToSuperview(offset: baseSize,usingSafeArea: true)
        weeklyCalendarView.leftToSuperview(offset: baseSize * 2, usingSafeArea: true)
        weeklyCalendarView.rightToSuperview(offset: baseSize * -2, usingSafeArea: true)
        
        circlularProgressView.topToBottom(of: weeklyCalendarView, offset: baseSize*2)
        circlularProgressView.centerXToSuperview()
        circlularProgressView.width(150)
        circlularProgressView.height(150)
        
        headerTitle.topToBottom(of: circlularProgressView, offset: baseSize * 2)
        headerTitle.leftToSuperview(offset: baseSize * 2, usingSafeArea: true)
        headerTitle.rightToSuperview(offset: baseSize * -2, usingSafeArea: true)
        
        imageCollectionView.topToBottom(of: headerTitle, offset: baseSize)
        imageCollectionView.leftToSuperview(usingSafeArea: true)
        imageCollectionView.rightToSuperview(usingSafeArea: true)
        imageCollectionView.bottomToSuperview(usingSafeArea: true)
    }

}


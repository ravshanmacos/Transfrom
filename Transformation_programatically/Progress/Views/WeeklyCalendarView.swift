//
//  CalendarView.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import UIKit
import TinyConstraints

class WeeklyCalendarView: UIView{
    
    private let components = UIComponents.shared
    private let cldHelper = CalendarHelper.shared
    private var progresses:[CGFloat] = []
    
    private var baseFontSize: CGFloat{
        return Constants.baseFontSize
    }
    
    private var baseSize: CGFloat{
        return Constants.baseSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ progresses: [CGFloat]) {
        self.init(frame: CGRect.zero)
        self.progresses = progresses
        setupViews()
    }
    
    private func setupViews(){
        let weekDaySymbols = cldHelper.getWeekdaySymbols()
        let weekStack = components.createStack(axis: .horizontal, spacing: 20, fillEqually: true)
        let circularProgressStack = components.createStack(axis: .horizontal, spacing: 20, fillEqually: true)
        for (index, weekSym) in weekDaySymbols.enumerated(){
            let dayOfMonth = cldHelper.getWeekday(date: Date())
            let sym = components.createLabel(with: weekSym, centered: true)
            let circularProgress = createCircularProgress(progress: progresses[index])
            let circleView = index == dayOfMonth ? createCircleView(childView: sym, active: true) : createCircleView(childView: sym)
            weekStack.addArrangedSubview(circleView)
            circularProgressStack.addArrangedSubview(circularProgress)
        }
        let wrapperStack = components.createStack(axis: .vertical ,fillEqually: true)
        wrapperStack.addArrangedSubviews([weekStack, circularProgressStack])
        addSubview(wrapperStack)
        wrapperStack.edgesToSuperview()
        circularProgressStack.height(40)
        
    }
    
}

//MARK: - UI Helpers
extension WeeklyCalendarView{
    
    private func createCircleView(childView: UIView, active: Bool = false)-> UIView{
        let parentView = UIView()
        let view = UIView()
        view.backgroundColor = active ? UIColor(named: "light_red") : .white
        (childView as! UILabel).textColor = active ? .white : .black
        view.addSubview(childView)
        parentView.addSubview(view)
        
        childView.centerInSuperview()
        view.centerInSuperview()
        view.height(30)
        view.width(30)
        view.layer.cornerRadius = 15
        return parentView
    }
    
    private func createCircularProgress(progress: CGFloat)->UIView{
        let view = UIView()
        let circularProgressView = CircularProgressView()
        circularProgressView.progress = progress
        view.addSubview(circularProgressView)
        circularProgressView.centerInSuperview()
        circularProgressView.height(30)
        circularProgressView.width(30)
        return view
    }
}

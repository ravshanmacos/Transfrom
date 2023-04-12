//
//  CalendarHelper.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/06.
//

import Foundation

struct CalendarHelper {
    static let shared = CalendarHelper()
    private let calendar = Calendar(identifier: .gregorian)
    private let dateFormatter = DateFormatter()
    
    func getFormattedDateString(_ date: Date = Date())->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y/LL/dd"
        return dateFormatter.string(from: date)
    }
    
    func getWeekdaySymbols()->[String]{
        return calendar.shortWeekdaySymbols.map{String($0.prefix(1))}
    }
    
    func getMonthName(date:Date)->String{
       dateFormatter.dateFormat = "LLLL"
       return dateFormatter.string(from: date)
    }
    
    func getYearName(date:Date)->String{
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getDayOfMonth(date:Date)->Int{
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func getDaysOfMonth(date:Date)->Int{
        let range = calendar.range(of: .day, in: .month, for: date)
        return range!.count
    }
    
    func getFirstDayOfMonth(date:Date)->Int{
        let components = calendar.dateComponents([.year, .month], from: date)
        let day = calendar.date(from: components)
        return getWeekday(date: day!)
    }
    
    func getWeekday(date:Date)->Int{
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday!-1
    }
    
    func changeToNextMonth(date:Date)->Date{
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func changeToPreviousMonth(date:Date)->Date{
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }

    
}

extension CalendarHelper{
    func compareYear(date1: Date, date2: Date)->Bool{
        let year1 = getYearName(date: date1)
        let year2 = getYearName(date: date2)
        return year1 == year2 ? true : false
    }
    
    func compareMonth(date1: Date, date2: Date)->Bool{
    let month1 = getMonthName(date: date1)
    let month2 = getMonthName(date: date2)
        return month1 == month2 ? true : false
    }
    
    func compareDay(date1: Date, date2: Date)->Bool{
        let day1 = getWeekday(date: date1)
        let day2 = getWeekday(date: date2)
            return day1 == day2 ? true : false
    }
}

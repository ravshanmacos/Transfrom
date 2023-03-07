//
//  TimerModel.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/03/02.
//

import Foundation
import Combine

class TimerModel{
    
    @Published var index = 0
    @Published var minutes: Int
    @Published var seconds: Int
    @Published var workoutPartFinished: Bool = false
    private var count = 20{
        didSet{
            seconds = count
        }
    }
    private var workoutLength: Int
    var timer: Timer
    
    init(minutes: Int, seconds: Int, length: Int) {
        self.minutes = minutes
        self.seconds = seconds
        workoutLength = length
        timer = Timer()
    }
    
    func updateWorkout(minutes: Int, seconds: Int){
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func startTimer(){
        print("Timer Started")
        guard minutes > 0 else{return}
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        print("Timer Stopped")
        timer.invalidate()
        minutes = 0
        seconds = 0
    }
    
    @objc private func timerAction(){
        if minutes == 0 && count == 0 {
            index += 1
        }else if count > 0{
            if count == 20 {minutes -= 1}
            count -= 1
        }else if count == 0{
            count = 20
        }
    }
}

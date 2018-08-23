//
//  Task.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 21.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import Foundation

class Task {
    
    var title : String = ""
    var info : String = ""
    var notes : String = ""
    var started : Bool = false
    var completed : Bool = false
    var taskExp : Int = 100
    var timesADay : Int = 1
    var everyXWeeks : Int = 1
    var everyXDays : Int = 1
    
    
    // Sun = 1
    var weekDays = [1: false,
                    2: false,
                    3: false,
                    4: false,
                    5: false,
                    6: false,
                    7: false]
    
    
//        var weekDays = ["Mon": false,
//                        "Tue": false,
//                        "Wed": false,
//                        "Thu": false,
//                        "Fri": false,
//                        "Sat": false,
//                        "Sun": false]


    
    
    func completeTask() {
        started = true
        completed = true
    }
    
    func skipTask() {
        started = true
        completed = false
    }
    
    func undoTask() {
        started = false
        completed = false
    }
}

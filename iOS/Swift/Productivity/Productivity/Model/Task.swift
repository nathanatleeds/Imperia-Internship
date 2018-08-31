//
//  Task.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 21.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import Foundation
import SwiftDate

class Task : NSObject {
    
   // var index : Int = 0
    var title : String = ""
    var info : String = ""
    var notes : String = ""
    var started : Bool = false
    var skipped : Bool = false
    var timesCompleted : Int = 0
    var completed : Bool = false
    var taskExp : Int = 100
    var timesADay : Int = 1
    var everyXWeeks : Int = 1
    var everyXDays : Int = 1
    var startDate : DateInRegion = DateInRegion(Date(), region: Region.local)
    
    var streak : Int = 0
    var dueInXDays : Int = 0
    
    
//    var weekDays = [1: false,
//                    2: false,
//                    3: false,
//                    4: false,
//                    5: false,
//                    6: false,
//                    7: false]
    
//        var weekDays = [1: 1,
//                        2: 0,
//                        3: 0,
//                        4: 0,
//                        5: 0,
//                        6: 0,
//                        7: 0]
//
    
    // if index = 0, last item = 0
//    override init() {
//    let defaults = UserDefaults.standard
//
//        if(defaults.object(forKey: "index") != nil) {
//            index = defaults.object(forKey: "index") as! Int + 1
//            defaults.set(index, forKey: "index")
//        } else {
//            defaults.set(0, forKey: "index")
//            index = 0
//        }
//        defaults.synchronize()
//    }
//
     //Sun = 1
    var weekDays = ["1": 0,
                    "2": 0,
                    "3": 0,
                    "4": 0,
                    "5": 0,
                    "6": 0,
                    "7": 0]
    
//        var weekDays = ["1": false,
//                        "2": false,
//                        "3": false,
//                        "4": false,
//                        "5": false,
//                        "6": false,
//                        "7": false]
    

    
    func completeTask() {
        started = true
        completed = true
    }
    
    func skipTask() {
        started = true
        skipped = true
        completed = false
    }
    
    func undoTask() {
        started = false
        completed = false
    }
    
    
    func toDictionary() -> [String : Any]{
        let dict = [
                    "title" : title,
                    "info" : info,
                    "notes" : notes,
                    "started" : started,
                    "skipped" : skipped,
                    "completed" : completed,
                    "taskExp" : taskExp,
                    "timesADay" : timesADay,
                    "everyXWeeks" : everyXWeeks,
                    "weekDays" : weekDays,
                    "timesCompleted" : timesCompleted,
                    "everyXDays" : everyXDays,
                    "streak" : streak,
                    "startDate" : startDate.toFormat("dd MMM yyyy HH:mm"),
                    "dueInXDays" : dueInXDays] as [String : Any]
        
        
        
        return dict
    }
    
//
//    //MARK:- NSCoding
//    required convenience init?(coder decoder: NSCoder) {
//        guard let title = decoder.decodeObject(forKey: "title") as? String,
//            let info = decoder.decodeObject(forKey: "info") as? String,
//            let notes = decoder.decodeObject(forKey: "notes") as? String,
//            let started = decoder.decodeObject(forKey: "started") as? Bool,
//            let completed = decoder.decodeObject(forKey: "completed") as? Bool,
//            let taskExp = decoder.decodeObject(forKey: "taskExp") as? Int,
//            let timesADay = decoder.decodeObject(forKey: "timesADay") as? Int,
//            let everyXWeeks = decoder.decodeObject(forKey: "everyXWeeks") as? Int,
//            let everyXDays = decoder.decodeObject(forKey: "everyXDays") as? Int,
//            let weekDays = decoder.decodeObject(forKey: "weekDays") as? [Int : Bool]
//            else { return nil }
//
//        
//    }
//
//
//
//    func encodeWithCoder(coder: NSCoder) {
//        coder.encode(self.title, forKey: "title")
//        coder.encode(self.info, forKey: "info")
//        coder.encode(self.notes, forKey: "notes")
//        coder.encode(self.started, forKey: "started")
//        coder.encode(self.completed, forKey: "completed")
//        coder.encode(self.taskExp, forKey: "taskExp")
//        coder.encode(self.timesADay, forKey: "timesADay")
//        coder.encode(self.everyXWeeks, forKey: "everyXWeeks")
//        coder.encode(self.everyXDays, forKey: "everyXDays")
//        coder.encode(self.weekDays, forKey: "weekDays")
//    }
}

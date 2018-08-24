//
//  Task.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 21.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import Foundation

class Task : NSObject {
    
   // var index : Int = 0
    var title : String = ""
    var info : String = ""
    var notes : String = ""
    var started : Bool = false
    var completed : Bool = false
    var taskExp : Int = 100
    var timesADay : Int = 1
    var everyXWeeks : Int = 1
    var everyXDays : Int = 1
    
    
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
    // Sun = 1
    var weekDays = [1: false,
                    2: false,
                    3: false,
                    4: false,
                    5: false,
                    6: false,
                    7: false]
    
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
    
    
    func toDictionary() -> [String : Any]{
        let dict = [
                    "title" : title,
                    "info" : info,
                    "notes" : notes,
                    "started" : started,
                    "completed" : completed,
                    "taskExp" : taskExp,
                    "timesADay" : timesADay,
                    "everyXWeeks" : everyXWeeks,
                   // "weekDays" : weekDays,
                    "everyXDays" : everyXDays] as [String : Any]
        
        return dict
    }
    
    
 //   //MARK:- NSCoding
//    required convenience init?(coder decoder: NSCoder) {
//        guard let title = decoder.decodeObject(forKey: "title") as? String,
//            let info = decoder.decodeObject(forKey: "info") as? String,
//            let notes = decoder.decodeObject(forKey: "notes") as? String,
//            let started = decoder.decodeObject(forKey: "started") as? Bool,
//            let completed = decoder.decodeObject(forKey: "completed") as? Bool,
//            let taskExp = decoder.decodeObject(forKey: "taskExp") as? Int,
//            let timesADay = decoder.decodeObject(forKey: "timesADay") as? Int,
//            let everyXWeeks = decoder.decodeObject(forKey: "everyXWeeks") as? Int,
//            let everyXDays = decoder.decodeObject(forKey: "everyXDays") as? Int
//            else { return nil }
//
//        self.init()
//    }
//
//    func encode(with aCoder: NSCoder) {
//        <#code#>
//    }
//
//
//    func encodeWithCoder(coder: NSCoder) {
//        coder.encode(self.title, forKey: "title")
//        coder.encodeObject(self.author, forKey: "author")
//        coder.encodeInt(Int32(self.pageCount), forKey: "pageCount")
//        coder.encodeObject(self.categories, forKey: "categories")
//        coder.encodeBool(self.available, forKey: "available")
//    }
}

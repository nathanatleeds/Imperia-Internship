//
//  User.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 22.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import Foundation

class User : NSObject {
    
    var level : Int = 1
    var neededExp : Int = 100
    var currentExp : Int = 0
    var coins : Int = 0

    
    func toDictionary() -> [String : Any] {
        let dict = [
            "level" : level,
            "neededExp" : neededExp,
            "currentExp" : currentExp,
            "coins" : coins] as [String : Any]
        
        return dict
    }
    
    func completeTask(completedTask: Task) {
        completedTask.timesCompleted += 1
        
        if(completedTask.timesCompleted == completedTask.timesADay) {
            completedTask.completeTask()
        }
        if(!completedTask.started) {
            completedTask.started = true
            currentExp += completedTask.taskExp / completedTask.timesADay + completedTask.taskExp % completedTask.timesADay
        }
    
        else {
            currentExp += completedTask.taskExp / completedTask.timesADay
        }
        

        
        if(currentExp >= neededExp) {
            levelUp()
        }
    }
    
    func undoTask(undoneTask: Task) {
        
        if(undoneTask.completed) {
            currentExp -= undoneTask.taskExp
            
            if(currentExp < 0) {
                levelDown()
            }
        } else if(undoneTask.started) {
            currentExp -= undoneTask.taskExp / undoneTask.timesADay + undoneTask.taskExp % undoneTask.timesADay
            currentExp -= undoneTask.taskExp / undoneTask.timesADay * (undoneTask.timesCompleted - 1)
        }
        undoneTask.started = false
        undoneTask.skipped = false
        undoneTask.timesCompleted = 0
    }
    
    func levelUp() {
        level += 1
        currentExp = currentExp - neededExp
        neededExp = level * level * 100
        coins += 500
    }
    
    func levelDown() {
        level -= 1
        
        neededExp = level * level * 100
        currentExp = neededExp + currentExp
        coins -= 500
    }
    
}

//
//  User.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 22.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import Foundation

class User {
    
    var level : Int = 1
    var neededExp : Int = 100
    var currentExp : Int = 0
    var coins : Int = 0

    
    func completeTask(completedTask: Task) {
        currentExp += completedTask.taskExp
        
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
        }
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

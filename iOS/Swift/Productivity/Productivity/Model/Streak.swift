//
//  Streak.swift
//  Productivity
//
//  Created by slaviyana chervenkondeva on 27.08.18.
//  Copyright © 2018 Slavyana Chervenkondeva. All rights reserved.
//

import UIKit

class Streak: NSObject {

    var activeDays : Int = 1
    var bestActiveDays : Int = 1
    var perfectDays : Int = 0
    var bestPerfectDays = 0


    func perfect() {
        perfectDays += 1
        
        if(perfectDays > bestPerfectDays) {
            bestPerfectDays = perfectDays
        }
        
    }
    
    func active() {
        activeDays += 1
        
        if(activeDays > bestActiveDays) {
            bestActiveDays = activeDays
        }
    }
    
}

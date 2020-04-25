//
//  DataManager.swift
//  Insanity
//
//  Created by Léa on 25/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import Foundation

struct DataManager {
    let dataWorkout = [
        Workout(id: 0, oldNumber: "50", newNumber: "60"),
        Workout(id: 1, oldNumber: "33", newNumber: "37"),
        Workout(id: 2, oldNumber: "45", newNumber: "41"),
        Workout(id: 3, oldNumber: "20", newNumber: "21"),
        Workout(id: 4, oldNumber: "5", newNumber: "8"),
        Workout(id: 5, oldNumber: "16", newNumber: "13"),
        Workout(id: 6, oldNumber: "17", newNumber: "26"),
        Workout(id: 7, oldNumber: "22", newNumber: "19")
    ]
    
    func Percent(old: String, new: String) -> String {
        let oldValue = Double(old)!
        let newValue = Double(new)!
        let percent: Double = ((newValue - oldValue) / oldValue) * 100
        let percentString = String(format: "%.0f", percent)
        
        if percent>=0 {
            return "+"+percentString+"%"
        } else {
            return percentString+"%"
        }
        
    }

}
 

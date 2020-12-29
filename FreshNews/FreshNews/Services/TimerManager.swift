//
//  File.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 29.12.20.
//

import Foundation

class TimerManager {
    
    
    var currentUpdatingTime: Int {
        get {
            return UserDefaults.standard.integer(forKey: "currentUpdatingTime")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentUpdatingTime")
        }
    }
    
    enum TimeUpdating: Int, CaseIterable {
        case veryFast = 5
        case fast = 10
        case medium = 30
        case slow = 60
        case verySlow = 90
    }
    
}

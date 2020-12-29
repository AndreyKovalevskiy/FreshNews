//
//  File.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 29.12.20.
//

import Foundation

class TimerManager {
    
    var updatingTimeChanged: Bool?
    
    var currentUpdatingTime: Int {
        get {
            let time = UserDefaults.standard.integer(forKey: "currentUpdatingTime")
            if time == 0 {
                return TimerManager.TimeUpdating.veryFast.rawValue
            }
            return time
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentUpdatingTime")
            NotificationCenter.default.post(name: .updatingTimeChanged, object: nil)
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

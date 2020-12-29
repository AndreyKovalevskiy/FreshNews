//
//  NatificationName+UpdatingTimeChanged.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 30.12.20.
//

import Foundation

extension Notification.Name {
    static var updatingTimeChanged: Notification.Name {
        return .init(rawValue: "Timer.updatingTimeChanged")
    }
}

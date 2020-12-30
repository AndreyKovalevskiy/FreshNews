//
//  NewsSource.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 24.12.20.
//

import Foundation

class NewsSource: NewsSourceProtocol {
    
    lazy var userDefaultsKey = "\(String(describing: type(of: self))).userDefaultsKey"
    
    var name: String
    var url: String
    var isEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: userDefaultsKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        }
    }
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
        isEnabled = true
    }
    
    @objc func toggle() {
        isEnabled.toggle()
    }
}

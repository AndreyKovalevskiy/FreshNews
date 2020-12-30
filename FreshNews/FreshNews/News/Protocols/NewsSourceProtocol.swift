//
//  NewsSourceProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 24.12.20.
//

import Foundation

@objc protocol NewsSourceProtocol {
    var name: String { get }
    var url: String { get }
    var isEnabled: Bool { get set }
    
    func toggle()
}


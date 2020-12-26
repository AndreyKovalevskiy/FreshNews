//
//  NewsSourceProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 24.12.20.
//

import Foundation

protocol NewsSourceProtocol {
    var name: String { get }
    var url: String { get }
    var isEnabled: Bool { get set }
    
    func enableSource()
    func disableSource()
}


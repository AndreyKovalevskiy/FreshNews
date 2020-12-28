//
//  Date+NewsFormat.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import Foundation

extension Date {
    var newsFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}

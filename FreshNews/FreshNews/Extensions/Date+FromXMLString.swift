//
//  Date+FromXMLString.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//

import Foundation

extension Date {
    static func fromXMLDateString(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: dateString)
        return date
    }
}

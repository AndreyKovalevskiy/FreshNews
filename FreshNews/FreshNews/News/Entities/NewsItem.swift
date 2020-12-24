//
//  NewsItem.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 24.12.20.
//

import UIKit

struct NewsItem {
    var title: String
    var sourceName: String
    var sourceURL: URL
    var description: String
    var date: Date
    var image: UIImage?
    var imageURL: URL?
    var isRead: Bool
}

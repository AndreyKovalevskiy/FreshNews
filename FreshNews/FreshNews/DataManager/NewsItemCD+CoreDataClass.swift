//
//  NewsItemCD+CoreDataClass.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//
//

import UIKit
import CoreData


public class NewsItemCD: NSManagedObject {

    func convertToNewsItem() -> NewsItem {

        return NewsItem(title: self.title!,
                        sourceName: self.sourceName!,
                        sourceURL: self.sourceURL!,
                        description: self.descriptionArticle!,
                        date: self.date!,
                        image: UIImage(data: self.image!)!,
                        imageURL: self.imageURL,
                        isRead: self.isRead)
    }
    
    func fill(from newsItem: NewsItem) {
        title = newsItem.title
        sourceName = newsItem.sourceName
        sourceURL = newsItem.sourceURL
        descriptionArticle = newsItem.description
        date = newsItem.date
        image = newsItem.image?.pngData()
        imageURL = newsItem.imageURL
        isRead = newsItem.isRead
    }
}

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

        var image: UIImage?
        if let data = self.image {
            image = UIImage(data: data)
        }
        
        return NewsItem(title: self.title!,
                        sourceName: self.sourceName!,
                        sourceURL: self.sourceURL!,
                        description: self.descriptionArticle!,
                        date: self.date!,
                        image: image,
                        imageURL: self.imageURL,
                        isRead: self.isRead)
    }
    
    func fill(from newsItem: NewsItem) {
        title = newsItem.title
        sourceName = newsItem.sourceName
        sourceURL = newsItem.sourceURL
        descriptionArticle = newsItem.description
        date = newsItem.date
        imageURL = newsItem.imageURL
        if !isRead {
            isRead = newsItem.isRead
        }
    }
}

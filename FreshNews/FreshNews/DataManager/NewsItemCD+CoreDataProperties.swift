//
//  NewsItemCD+CoreDataProperties.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//
//

import Foundation
import CoreData


extension NewsItemCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsItemCD> {
        return NSFetchRequest<NewsItemCD>(entityName: "NewsItemCD")
    }

    @NSManaged public var title: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var sourceURL: URL?
    @NSManaged public var descriptionArticle: String?
    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var imageURL: URL?
    @NSManaged public var isRead: Bool

}

extension NewsItemCD : Identifiable {

}

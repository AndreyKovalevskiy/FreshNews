//
//  StoreManager.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//

import CoreData

class StoreManager: StoreManagerProtocol {
    
    let mainContext = CoreDataManager.shared.persistentContainer.viewContext
    let backGroundContext = CoreDataManager.shared.persistentContainer.newBackgroundContext()
    
    func fetchNews(from sources: [NewsSourceProtocol], completion: @escaping ([NewsItem]) -> Void) {
        
        var news: [NewsItem] = []
        
        for source in sources {
            
            let fetchRequest = NSFetchRequest<NewsItemCD>(entityName: "NewsItemCD")
            fetchRequest.predicate = NSPredicate(format: "sourceURL = %@", source.url)
            
            do {
                let result = try mainContext.fetch(fetchRequest)
                let sourceNews = result.map { $0.convertToNewsItem() }
                news.append(contentsOf: sourceNews)
            } catch {
                print(error)
            }
        }
        let sortedNews = news.sorted { $0.date > $1.date }
        completion(sortedNews)
    }
    
    
    func save(news: [NewsItem]) {
        
        news.forEach { (item) in
            if let cdItem = newsItemExists(sourceUrl: item.sourceURL, date: item.date) {
                cdItem.fill(from: item)
            } else {
                let newCdItem = NewsItemCD(context: backGroundContext)
                newCdItem.fill(from: item)
            }
        }
        
        do {
            if backGroundContext.hasChanges {
                try backGroundContext.save()
            }
        } catch {
            print(error)
        }
    }
    
    private func newsItemExists(sourceUrl: URL, date: Date) -> NewsItemCD? {
        
       // let context = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        let request = NSFetchRequest<NewsItemCD>(entityName: "NewsItemCD")
        request.predicate = NSPredicate(
            format: "sourceURL = %@ AND date = %@",
            sourceUrl as NSURL,
            date as NSDate
        )
        
        do {
            let entity = try backGroundContext.fetch(request)
            
            return entity.first
        } catch {
            print(error)
        }
        
        return nil
    }
}

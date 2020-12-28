//
//  StoreManager.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//

import CoreData

class StoreManager: StoreManagerProtocol {
    
    func fetchNews(from sources: [NewsSourceProtocol], completion: @escaping ([NewsItem]) -> Void) {
        
        var news: [NewsItem] = []

        for source in sources {

            let context = CoreDataManager.shared.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NewsItemCD>(entityName: "NewsItemCD")
            fetchRequest.predicate = NSPredicate(format: "sourceURL = %@", source.url)

            do {
                let result = try context.fetch(fetchRequest)
                let sourceNews = result.map { $0.convertToNewsItem() }
                news.append(contentsOf: sourceNews)
            } catch {
                print(error)
            }
        }

        completion(news)
    }
    
    
    func save(news: [NewsItem]) {
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (context) in
            for item in news {
                let newsItemCD = NewsItemCD(context: context)
                newsItemCD.fill(from: item)
            }
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    
    
}

//
//  NewsIteractor.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//

import Foundation

class NewsIteractor: NewsIteractorProtocol {
    var presenter: NewsPresenterProtocol?
    var storeManager: StoreManagerProtocol
    var sorceManager: SourceManager
    
    init() {
        storeManager = StoreManager()
        sorceManager = SourceManager()
    }
    
    func loadNews() {
        
        sorceManager.allRecources().forEach { (NewsSource) in
            NewsSource.isEnabled = true
        }
        
        let sources = sorceManager.isEnebledSources()
        var newsItems = [NewsItem]()
        
        for source in sources {
            let networkManager = NetworkManager(newsSource: source)
            networkManager.loadNews { (items, error) in
                if let items = items {
                    newsItems.append(contentsOf: items)
                }
            }
        }
        
        let sortedNewsItems = newsItems.sorted { $0.date > $1.date }
        storeManager.save(news: sortedNewsItems)
        fetchNews()
    }
    
    func fetchNews() {
        storeManager.fetchNews(from: sorceManager.isEnebledSources()) { (items) in
            if items.isEmpty {
                self.loadNews()
            } else {
                self.presenter?.newsReceived(news: items)
            }
            
            
        }
    }
    
    
}

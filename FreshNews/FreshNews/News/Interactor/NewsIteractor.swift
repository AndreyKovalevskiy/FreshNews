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
        sorceManager = SourceManager.shared
    }
    
    func loadNews() {
        
        var newsItems = [NewsItem]()
        let queue = DispatchQueue(label: "loadNews",
                                  qos: .default,
                                  attributes: .concurrent)
        let group = DispatchGroup()
        
        queue.async(group: group) {
            
            let sources = self.sorceManager.isEnebledSources()
            
            for source in sources {
                group.enter()
                let networkManager = NetworkManager(newsSource: source)
                networkManager.loadNews { (items, error) in
                    if let items = items {
                        newsItems.append(contentsOf: items)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            let sortedNewsItems = newsItems.sorted { $0.date > $1.date }
            self.storeManager.save(news: sortedNewsItems)
            self.fetchNews()
        }
    }
    
    func fetchNews() {
        storeManager.fetchNews(from: sorceManager.isEnebledSources()) { [weak self] (items) in
            guard let self = self else { return }
            if items.isEmpty {
                self.loadNews()
            } else {
                self.presenter?.newsReceived(news: items)
            }
        }
    }
    
    func updateInDataBase(newsItem: NewsItem) {
        storeManager.save(news: [newsItem])
    }
}

//
//  NewsIteractor.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//

import Foundation

class NewsIteractor: NewsIteractorProtocol {
    var presenter: NewsPresenterProtocol?
    
    func fetchNews() {
        let networkManager = NetworkManager(newsSource: LentaRuNewsSource())
        networkManager.fetchNews { (newsItems, error) in
            if let newsItems = newsItems {
                self.presenter?.newsReceived(news: newsItems)
            }
        }
    }
    
    
}

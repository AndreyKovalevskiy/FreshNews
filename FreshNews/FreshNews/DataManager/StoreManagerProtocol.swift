//
//  StoreManagerProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 28.12.20.
//

import Foundation

protocol StoreManagerProtocol {
    
    func fetchNews(from Sources: [NewsSourceProtocol], completion: @escaping ([NewsItem]) -> Void)
    func save(news: [NewsItem])
}

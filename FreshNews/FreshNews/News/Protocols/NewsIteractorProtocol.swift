//
//  NewsIteractorProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import Foundation

protocol NewsIteractorProtocol {
    var presenter: NewsPresenterProtocol? { get set }
    
    func fetchNews()
    func updateInDataBase(newsItem: NewsItem)
    func loadNews()
}

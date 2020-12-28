//
//  NewsFetchingProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import Foundation

protocol NewsFetchingProtocol {
    func fetchNews(completion: @escaping (([NewsItem]?, Error?) -> ()))
}

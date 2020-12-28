//
//  NewsFetchingProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import Foundation

protocol NewsLoadingProtocol {
    func loadNews(completion: @escaping (([NewsItem]?, Error?) -> ()))
}

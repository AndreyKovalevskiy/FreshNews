//
//  NetworkManager.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import Foundation

class NetworkManager: NewsLoadingProtocol {
    
    var newsSource: NewsSourceProtocol
    
    init(newsSource: NewsSourceProtocol) {
        self.newsSource = newsSource
    }
    
    func loadNews(completion: @escaping (([NewsItem]?, Error?) -> ())) {
        
        guard let url = URL(string: newsSource.url) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                let parser = NewsParser(data: data, newsSource: self.newsSource)
                parser.parseXML()
                completion(parser.newsItems, nil)
            } else {
                completion(nil, NetworkError.invalidData)
            }
            
        }
        dataTask.resume()
    }
}

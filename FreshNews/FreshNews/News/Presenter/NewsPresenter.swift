//
//  NewsPresenter.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import Foundation

class NewsPresenter: NewsPresenterProtocol {
    
    var view: NewsViewProtocol?
    var interactor: NewsIteractorProtocol?
    var router: NewsRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchNews()
    }
    
    func showSettings() {
        router?.showSetings()
    }
    
    func newsReceived(news: [NewsItem]) {
        DispatchQueue.main.async {
            self.view?.updateUI(with: news)
        }
    }
    
    func newsFetchFail(source: [NewsSource]) {
        
    }
    
    
    
}

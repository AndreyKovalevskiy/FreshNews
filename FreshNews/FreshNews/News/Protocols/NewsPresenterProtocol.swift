//
//  NewsPresenterProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import Foundation

protocol NewsPresenterProtocol {
    var view: NewsViewProtocol?  { get set }
    var interactor: NewsIteractorProtocol? { get set }
    var router: NewsRouterProtocol? { get set }
    
    //View -> Presenter
    func viewDidLoad()
    func showSettings()
    func showTimerSettings()
    func update(newsItem: NewsItem)
    
    //Iteractor -> Presenter
    func newsReceived(news: [NewsItem])
    func newsFetchFail(source: [NewsSource])
}

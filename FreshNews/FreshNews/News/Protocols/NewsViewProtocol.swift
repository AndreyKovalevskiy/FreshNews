//
//  NewsViewProtocol.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import Foundation

protocol NewsViewProtocol {

    var presenter: NewsPresenterProtocol? { get set }
    
    //Presenter -> View
    func updateUI(with newsItems: [NewsItem])
    func showError(message: String)
}

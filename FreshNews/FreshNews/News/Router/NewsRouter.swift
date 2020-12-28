//
//  NewsRouter.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import UIKit
import Foundation

class NewsRouter: NewsRouterProtocol {
    
    var navigationController: UINavigationController?
    
    init() {
        createNewsModule()
    }
    
    
    func createNewsModule() {
        let view = NewsViewController()
        let presenter = NewsPresenter()
        let interactor = NewsIteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.interactor = interactor
        interactor.presenter = presenter
        navigationController = UINavigationController(rootViewController: view)
    }
    
    func showSetings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func showTimerSettings() {
        
    }
    
    
}

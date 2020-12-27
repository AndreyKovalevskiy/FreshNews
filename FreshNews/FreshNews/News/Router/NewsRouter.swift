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
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        navigationController = UINavigationController(rootViewController: view)
    }
    
    func showSetings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func showTimerSettings() {
        
    }
    
    
}

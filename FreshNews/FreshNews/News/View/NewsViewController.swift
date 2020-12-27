//
//  NewsViewController.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import UIKit

class NewsViewController: UIViewController, NewsViewProtocol {
    
    var presenter: NewsPresenterProtocol?
    
    var newsList = [NewsItem]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.registerCell(of: NewsTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fresh news"
        view.addSubview(tableView)
        addSettingsButton()
    }
    
    func addSettingsButton() {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(pressedSettingsButton))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func pressedSettingsButton() {
        presenter?.showSettings()
    }
    
    func updateUI(with newsItems: [NewsItem]) {
        
    }
    
    func showError(message: String) {
        
    }
    
}

//MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsItem = newsList[indexPath.row]
        let cell = tableView.dequeueCell(of: NewsTableViewCell.self)!
        cell.fill(with: newsItem)
        return cell
    }
    
}

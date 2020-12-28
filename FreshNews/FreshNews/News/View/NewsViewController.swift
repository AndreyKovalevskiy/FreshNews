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
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
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
        newsList = newsItems
        tableView.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
}

//MARK: - UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        var newsItem = newsList[indexPath.row]
        
        if !newsItem.isRead {
            newsItem.isRead = true
        }
        newsList[indexPath.row] = newsItem

        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell else { return }
        cell.fill(with: newsItem)
        cell.isOpened = !cell.isOpened

        tableView.beginUpdates()
        tableView.endUpdates()
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
       // let data = try? Data(contentsOf: newsItem.imageURL!)
        //newsItem.image = UIImage(data: data!)
        cell.fill(with: newsItem)
        return cell
    }
    
}

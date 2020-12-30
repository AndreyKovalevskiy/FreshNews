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
    
    var timer: Timer?
    
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
        createTimer()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatingTimeChanged),
                                               name: .updatingTimeChanged,
                                               object: nil
        )
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
            presenter?.update(newsItem: newsItem)
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
        cell.fill(with: newsItem)
        return cell
    }
    
}

// MARK: - Timer

extension NewsViewController {
    
    func createTimer() {
        
        if timer == nil {
            
            let timeInterval = TimerManager().currentUpdatingTime
            let timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval),
                                             target: self,
                                             selector: #selector(updateNews),
                                             userInfo: nil,
                                             repeats: true)
            timer.tolerance = 0.1
            RunLoop.current.add(timer, forMode: .common)
            self.timer = timer
        }
    }
    
    @objc func updateNews() {
        presenter?.loadNews()
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updatingTimeChanged() {
        cancelTimer()
        createTimer()
    }
}

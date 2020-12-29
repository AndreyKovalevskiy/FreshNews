//
//  UpdateTimeSettingsViewController.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 29.12.20.
//

import UIKit

class UpdateTimeSettingsViewController: UIViewController {

    private let timerManager = TimerManager()
    
    var selectedIndex: IndexPath?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension UpdateTimeSettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowValues = TimerManager.TimeUpdating.allCases.map { $0.rawValue }
        return rowValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowValues = TimerManager.TimeUpdating.allCases.map { $0.rawValue }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = String(rowValues[indexPath.row])
        
        if rowValues[indexPath.row] == timerManager.currentUpdatingTime {
            cell.accessoryType = .checkmark
            selectedIndex = indexPath
        } else {
            cell.accessoryType = .none
        }
       
        return cell
    }
}

extension UpdateTimeSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowValues = TimerManager.TimeUpdating.allCases.map { $0.rawValue }
        
        tableView.deselectRow(at: indexPath, animated: true)

        let prevCell = tableView.cellForRow(at: selectedIndex!)
        prevCell?.accessoryType = .none

        let updatingTime = rowValues[indexPath.row]
        timerManager.currentUpdatingTime = updatingTime

        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedIndex = indexPath
    }
}


//
//  SettingsViewController.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import UIKit

class SettingsViewController: UIViewController {

    var presenter: NewsPresenterProtocol?
    let sourceManager = SourceManager()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sourceManager.allRecources().count
        case 1:
            return 1
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)

            let source = sourceManager.allRecources()[indexPath.row]
            cell.textLabel?.text = source.name
            let switchView = UISwitch()
            switchView.isOn = source.isEnabled
            switchView.addTarget(source, action: #selector(NewsSource.toggle), for: .valueChanged)
            cell.accessoryView = switchView
            cell.selectionStyle = .none

            return cell
        case 1:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            let updateTimer = TimerManager().currentUpdatingTime

            cell.textLabel?.text = "Autoupdate time"
            cell.detailTextLabel?.text = "\(updateTimer) sec"
            cell.accessoryType = .disclosureIndicator

            return cell
        default:
            fatalError("Unrecognized inde ")
        }
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if indexPath.row == 0 {
                presenter?.showTimerSettings()
            }
        default:
            return
        }
    }
}

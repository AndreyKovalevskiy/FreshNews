//
//  UITableView+ReusableCell.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 26.12.20.
//

import UIKit

extension UITableView {
    
    func registerCell<T: UITableViewCell>(of typeCell: T.Type) {
        register(typeCell, forCellReuseIdentifier: typeCell.reuseIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell>(of typeCell: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: typeCell.reuseIdentifier) as? T
    }
}

//
//  UITableView+Ext.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit
 
extension UITableView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

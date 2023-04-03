//
//  EmployeeListDataSource.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

class EmployeeListDataSource: NSObject {
    private let viewModel: EmployeeListViewModel

    init(viewModel: EmployeeListViewModel) {
        self.viewModel = viewModel
    }
}

//  MARK: - UITableViewDataSource
extension EmployeeListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeListCell.reuseIdentifier, for: indexPath) as! EmployeeListCell
        if let item: EmployeeCellViewModel = viewModel.getItemAtIndex(indexPath.row) {
            cell.configure(item)
        }
        return cell        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
}

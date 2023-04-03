//
//  EmployeeDetailsDataSource.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

class EmployeeDetailsDataSource: NSObject {
    private let viewModel: EmployeeDetailsViewModel

    init(viewModel: EmployeeDetailsViewModel) {
        self.viewModel = viewModel
    }
}


// MARK: - UITableViewDataSource
extension EmployeeDetailsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeDetailsCell.reuseIdentifier, for: indexPath) as! EmployeeDetailsCell
        if let item: EmployeeDetailsCellViewModel = viewModel.getItemAtIndex(indexPath.row) {
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

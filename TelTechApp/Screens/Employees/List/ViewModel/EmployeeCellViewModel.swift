//
//  EmployeeCellViewModel.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

class EmployeeCellViewModel: EmployeeItemProtocol {
    var employee: Employee
    
    init(employee: Employee) {
        self.employee = employee
    }
}

extension EmployeeCellViewModel {
    var title: String {
        employee.title
    }
}

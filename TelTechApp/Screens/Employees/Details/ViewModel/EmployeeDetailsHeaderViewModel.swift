//
//  EmployeeDetailsHeaderViewModel.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//


import UIKit

class EmployeeDetailsHeaderViewModel: EmployeeItemProtocol {
    var employee: Employee
    
    init(employee: Employee) {
        self.employee = employee
    }
}


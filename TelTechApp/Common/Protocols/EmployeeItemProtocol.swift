//
//  EmployeeItemProtocol.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

protocol EmployeeItemProtocol {
    var employee: Employee { get }
    var name: String { get }
    var employeeImage: UIImage? { get }
    var intro: String { get }
}


//  MARK: - Computed properties
extension EmployeeItemProtocol {
    var name: String {
        return "\(employee.name) \(employee.surname)"
    }
    var employeeImage: UIImage? {
        Utility.randomImage()
    }
    var intro: String {
        employee.intro
    }
}

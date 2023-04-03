//
//  EmployeesRepository.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - EmployeesRepositoryProtocol
protocol EmployeesRepositoryProtocol {
    func getEmployees() -> AnyPublisher<[Employee], Error>
}


//  MARK: - EmployeesRepository
class EmployeesRepository: EmployeesRepositoryProtocol {
//    let apiService: EmployeesAPIProtocol
    let localStorageService: EmployeesLocalStorageProtocol
    
    init(localStorageService: EmployeesLocalStorageProtocol) {
        self.localStorageService = localStorageService
    }
    
    func getEmployees() -> AnyPublisher<[Employee], Error> {
        return getEmployeesFromLocalStorage()
    }
}


//  MARK: - Fetch data from local storage (file)
private extension EmployeesRepository {
    func getEmployeesFromLocalStorage() -> AnyPublisher<[Employee], Error> {
        return localStorageService.getEmployeesFromLocalStorage()
    }
}


//  MARK: - Fetch data from API
private extension EmployeesRepository {}

//
//  EmployeesLocalStorageService.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - EmployeesLocalStorageProtocol
protocol EmployeesLocalStorageProtocol {
    var fileManager: FilesManager { get }
    func getEmployeesFromLocalStorage() -> AnyPublisher<[Employee], Error>
}


//  MARK: - EmployeesLocalStorageService
class EmployeesLocalStorageService: EmployeesLocalStorageProtocol {
    var fileManager: FilesManager
    private let fileName: String
    private let fileExtension: String
    
    init(fileManager: FilesManager, fileName: String, fileExtension: String) {
        self.fileManager = fileManager
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    func getEmployeesFromLocalStorage() -> AnyPublisher<[Employee], Error> {
        guard let data = try? fileManager.loadDataFromFile(fileName: fileName, fileExtension: fileExtension) else {
            return Fail(error: AppError.noFileFound).eraseToAnyPublisher()
        }
        guard let jsonData = try? JSONDecoder().decode(DecodedArray<[Employee]>.self, from: data) else {
            return Fail(error: AppError.fetchDataError).eraseToAnyPublisher()
        }
        return Just(jsonData.array.flatMap { $0 })
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

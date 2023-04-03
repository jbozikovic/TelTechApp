//
//  EmployeesLocalStorageServiceTests.swift
//  TelTechAppTests
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import XCTest
@testable import TelTechApp
import Combine

class EmployeesLocalStorageServiceTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testEmployeesFromLocalStorage() {
        let localStorageService = EmployeesLocalStorageService(fileManager: FilesManager(), fileName: AppConfig.dataFileName, fileExtension: Constants.jsonFileExtension)        
        let expectation = self.expectation(description: #function)
        var error: Error? = nil
        var employees: [Employee] = []
        localStorageService.getEmployeesFromLocalStorage()
            .sink { completion in
                switch completion {
                case .failure(let apiError):
                    error = apiError
                case .finished:
                    break
                }
                expectation.fulfill()
            } receiveValue: { result in
                employees = result
            }.store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssertEqual(employees.isEmpty, false, "Not ok, array shouldn't be empty")        
    }

}

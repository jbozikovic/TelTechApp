//
//  FileManagerTests.swift
//  TelTechAppTests
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import XCTest
@testable import TelTechApp

class FileManagerTests: XCTestCase {
    func testReadFromFile() {
        let fileManager = FilesManager()
        let fileName = AppConfig.dataFileName
        let fileExtension = Constants.jsonFileExtension
        do {
            let data = try fileManager.loadDataFromFile(fileName: fileName, fileExtension: fileExtension)
            XCTAssertEqual(data.isEmpty, false, "Not ok, shouldn't be empty")
        } catch {
            XCTAssertNil(error)
        }
    }
}

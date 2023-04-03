//
//  FilesManager.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import Combine

class FilesManager: FilesManagerProtocol {
    typealias T = Data
    func loadDataFromFile(fileName: String, fileExtension: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
            throw AppError.noFileFound
        }
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            Utility.printIfDebug(string: "Error loading file: \(error)")
            throw error
        }
    }    
}

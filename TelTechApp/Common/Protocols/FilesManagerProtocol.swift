//
//  FilesManagerProtocol.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

protocol FilesManagerProtocol {
    associatedtype T
    func loadDataFromFile(fileName: String, fileExtension: String) throws -> T
}

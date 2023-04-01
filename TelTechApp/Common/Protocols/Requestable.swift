//
//  Requestable.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

//  MARK: - Requestable protocol
protocol Requestable {
    var method: HTTPMethod { get }
    var url: String { get }
    var params: JSON? { get }
    var headers: [HTTPHeader]? { get }
}

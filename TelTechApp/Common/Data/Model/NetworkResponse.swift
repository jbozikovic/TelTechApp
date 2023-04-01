//
//  NetworkResponse.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

struct NetworkResponse<T> {
    let value: T
    let response: URLResponse
}

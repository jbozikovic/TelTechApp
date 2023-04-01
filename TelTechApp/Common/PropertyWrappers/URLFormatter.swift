//
//  URLFormatter.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

@propertyWrapper
struct URLFormatter {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? wrappedValue
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? wrappedValue
    }
}

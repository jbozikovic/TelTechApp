//
//  ErrorHandlerProtocol.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

protocol ErrorHandlerProtocol: Presentable {
    func handleError(_ error: Error, title: String?)
}

extension ErrorHandlerProtocol where Self: UIViewController {
    func handleError(_ error: Error, title: String? = nil) {
        presentAlertController(title: title, message: error.localizedDescription, showCancelButton: false, confirmHandler: nil)
    }
}

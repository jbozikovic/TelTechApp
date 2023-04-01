//
//  ViewStyleable.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

protocol ViewStyleable {
    func setupGUI()
    func setupBackground()
}

extension ViewStyleable where Self: UIViewController {
    func setupBackground() {
        view.backgroundColor = AppUI.defaultBgColor
    }
}

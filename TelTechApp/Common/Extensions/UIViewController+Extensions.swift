//
//  UIViewController+Extensions.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

extension UIViewController {
    var screenName: String {
        return String(describing: type(of: self))
    }
}

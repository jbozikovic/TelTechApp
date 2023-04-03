//
//  AnalyticsProtocol.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

//  MARK: - Analytics Protocol
protocol AnalyticsProtocol {
    func logEvent(_ event: AnalyticsEvents, parameters: [String : Any]?)
    func trackScreen(screenName: String)
}

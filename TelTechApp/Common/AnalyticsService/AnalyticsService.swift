//
//  AnalyticsService.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 03.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

//  MARK: - Analytics Events
enum AnalyticsEvents: String {
    case userTappedEmployee = "user_tapped_employee"
    case userOpenedScreen = "user_opened_screen"
}

//  MARK: - Analytics Keys
enum AnalyticsKeys: String {
    case screenName = "screen_name"
}


//  MARK: - AnalyticsService
class AnalyticsService: AnalyticsProtocol {
    func logEvent(_ event: AnalyticsEvents, parameters: [String : Any]?) {
        Utility.printIfDebug(string: "Tracking event \(event.rawValue)")
//        Analytics.logEvent(event.rawValue, parameters: parameters)
    }

    func trackScreen(screenName: String) {
        Utility.printIfDebug(string: "Tracking screen \(screenName)")
        logEvent(AnalyticsEvents.userOpenedScreen, parameters: [AnalyticsKeys.screenName.rawValue: screenName])
    }
}

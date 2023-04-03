//
//  Utility.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import UIKit

class Utility: NSObject {
    //  MARK: - String
    static func stringNilOrEmpty(string: String?) -> Bool {
        return (string ?? "").isEmpty
    }
        
    static func generateUUIDString() -> String {
        return UUID().uuidString
    }
    
    //  MARK: - Print if DEBUG
    static func printIfDebug(string: String) {
        #if DEBUG
        print(string)
        #endif
    }
            
    //  MARK: - UIBarButtonItem
    static func createBarButtonItem(image: UIImage?, target: Any, action: Selector, identifier: String) -> UIBarButtonItem {
        let btn = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        btn.accessibilityIdentifier = identifier
        btn.tintColor = .gray
        return btn
    }
    
    //  MARK: - Setup label
    static func setupLabel(_ label: UILabel, font: UIFont, textColor: UIColor, numberOfLines: Int = AppUI.defaultNumberOfLines, textAlignment: NSTextAlignment = .left, text: String = "") {
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.text = text
        label.textAlignment = textAlignment
    }
    
    //  MARK: Check url string
    static func isValidUrl(urlString: String) -> URL? {
        guard let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) else { return nil }
        return url
    }
    
    //  MARK: - Random image
    static func randomImage() -> UIImage? {
        let images = [AppImages.employee1.image, AppImages.employee2.image, AppImages.employee3.image, AppImages.employee4.image, AppImages.employee5.image, AppImages.employee6.image, AppImages.employee7.image, AppImages.employee8.image, AppImages.employee9.image, AppImages.employee10.image]
        return images.randomElement() ?? AppImages.noImage.image
    }
}


//  MARK: - Reachability, Internet connection
extension Utility {
    static var hasInternetConnection: Bool {
        guard let reachability = Reachability(), reachability.isConnected else {
            return false
        }
        return true
    }
}

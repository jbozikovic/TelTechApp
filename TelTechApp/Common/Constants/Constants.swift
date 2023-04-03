//
//  Constants.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import UIKit


//  MARK: - Constants
struct Constants {
    private init() {}
            
    static let networkTimeout: TimeInterval = 10     //  network timeout in seconds ...
    static let defaultNumberOfSections: Int = 1
    static let numberOfItemsPerPage: Int = 30
    static let dateFormat: String = "MMM dd, yyyy"
    static let dateFormatFull: String = "yyyy-MM-dd HH:mm:ss"
    static let jsonFileExtension = "json"
}


//  MARK: - App config
struct AppConfig {
    private init() {}
    
    static let dataFileName = "teltechians"
}


//  MARK: - AppUI
struct AppUI {
    static let alphaHidden: CGFloat = 0.0
    static let alphaVisible: CGFloat = 1.0
    static let alphaTransparent: CGFloat = 0.5
    static let backgroundColor: UIColor = .white
    static let bodyFontColor: UIColor = .white //.darkGray
    static let bodyFontSize: CGFloat = 15.0
    static let buttonColor: UIColor = .cyan
    static let checkMarkIcon = "✔︎"
    static let cornerRadius: CGFloat = 4.0
    static let defaultFont = UIFont.systemFont(ofSize: 15.0)
    static let defaultFontBold = UIFont.boldSystemFont(ofSize: 15.0)
    static let defaultBgColor: UIColor = UIColor(red: 34.0/255.0, green: 52.0/255.0, blue: 60.0/255.0, alpha: 1.0) // .white
    static let navigationBarBGColor: UIColor = .white
    static let navigationBarTintColor: UIColor = .black
    static let navigationBarLargeTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 24.0)
    static let listTitleFont = UIFont.boldSystemFont(ofSize: 17.0)
    static let titleFontColor: UIColor = UIColor(red: 62.0/255.0, green: 213.0/255.0, blue: 152.0/255.0, alpha: 1.0) // .black
    static let titleFont = UIFont.boldSystemFont(ofSize: 24.0)
    static let defaultNumberOfLines: Int = 1
    static let separatorColor: UIColor = UIColor(red: 150.0/255.0, green: 167.0/255.0, blue: 175.0/255.0, alpha: 1.0) // .black
    
}


//  MARK: - AppImages
enum AppImages: String {
    case noImage = "photo.fill"    
    case employee1 = "employee1"
    case employee2 = "employee2"
    case employee3 = "employee3"
    case employee4 = "employee4"
    case employee5 = "employee5"
    case employee6 = "employee6"
    case employee7 = "employee7"
    case employee8 = "employee8"
    case employee9 = "employee9"
    case employee10 = "employee10"
        
    var image: UIImage? {
        guard let systemImage = UIImage(systemName: self.rawValue) else {
            return UIImage(named: self.rawValue)
        }
        return systemImage
    }    
}


//  MARK: - AppStrings
enum AppStrings: String {
    case aboutMe = "about_me"
    case agency = "agency"
    case cancel = "cancel"
    case details = "details"
    case employees = "employees"
    case errorOccured = "error"
    case fetchDataFailed = "fetch_data_failed"
    case genericErrorMessage = "error_occurred_try_again"
    case noData = "no_data"
    case noFile = "no_file"
    case noInternet = "no_internet_connection"
    case notAvailable = "not_available"
    case ok = "ok"
    case team = "team"
    case title = "title"
        
    var localized: String {
        return self.rawValue.localized()
    }
}


//  MARK: - AppUrls
struct AppUrls {
    private init() {}
    
    static let baseUrl                          = "https://"    
    static let employees                        = "employees/"
}


//  MARK: - AppKeys
enum AppKeys {}


//  MARK: - HTTPCode
enum HTTPCode: Int {
    case notAuthorized = 401
    case notFound = 404
    
    func message() -> String {
        switch self {
        case .notAuthorized:
            return ""
        case .notFound:
            return ""
        }
    }
    
    func title() -> String {
        switch self {
        case .notAuthorized:
            return ""
        case .notFound:
            return ""
        }
    }
}


//  MARK: - AppError
enum AppError: Error {
    case genericError
    case noData
    case noInternet
    case fetchDataError
    case noFileFound
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return AppStrings.noData.rawValue
        case .noInternet:
            return AppStrings.noInternet.localized
        case .fetchDataError:
            return AppStrings.fetchDataFailed.localized
        case .noFileFound:
            return AppStrings.noFile.localized
        default:
            return AppStrings.genericErrorMessage.localized
        }
    }
}


//  MARK: - Typealiases
typealias JSON = [String: Any]



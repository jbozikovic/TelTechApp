//
//  Employee.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

struct Employee: Decodable, IDable {
    var id: String
    var name: String
    var surname: String
    var image: String
    var title: String
    var agency: String
    var intro: String
    var description: String
    var team: String    
    
    enum CodingKeys: CodingKey {
        case name
        case surname
        case image
        case title
        case agency
        case intro
        case description
   }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = Utility.generateUUIDString()
        name = try container.decode(String.self, forKey: CodingKeys.name)
        surname = try container.decode(String.self, forKey: CodingKeys.surname)
        image = try container.decode(String.self, forKey: CodingKeys.image)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        agency = try container.decode(String.self, forKey: CodingKeys.agency)
        intro = try container.decode(String.self, forKey: CodingKeys.intro)
        description = try container.decode(String.self, forKey: CodingKeys.description)
        // Extract team from coding path
        team = container.codingPath.first?.stringValue ?? ""
    }
}


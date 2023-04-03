//
//  DecodedArray.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation

struct DecodedArray<T: Decodable>: Decodable {
    var array: [T]

    //  DynamicCodingKeys type needed for creating decoding container from JSONDecoder
   private struct DynamicCodingKeys: CodingKey {
       var stringValue: String
       var intValue: Int?
       
       init?(stringValue: String) {
           self.stringValue = stringValue
       }
       
       init?(intValue: Int) {
           //   Not using, so we'll return nil
           return nil
       }
   }

    init(from decoder: Decoder) throws {
        //  Container for all the JSON first level keys
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        array = try container.allKeys.map {
            try container.decode(T.self, forKey: $0)
        }
    }
}

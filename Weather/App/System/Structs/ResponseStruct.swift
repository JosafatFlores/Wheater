//
//  ResponseStruct.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import Foundation
struct ResponseStruct: Codable {
    var city_name: String?
    var timezone: String?
    var country_code: String?
    var data: [ClimateStruct]?
}

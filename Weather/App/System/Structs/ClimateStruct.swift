//
//  ClimateStruct.swift
//  Weather
//
//  Created by Test on 12/03/21.
//

import Foundation
struct ClimateStruct: Codable {
    var min_temp: Float
    var max_temp: Float
    var temp: Float
    var datetime: String
    var weather: WeaterStruct
}

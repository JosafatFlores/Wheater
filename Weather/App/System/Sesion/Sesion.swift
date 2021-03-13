//
//  Sesion.swift
//  Weather
//
//  Created by Test on 11/03/21.
//

import Foundation
import UIKit
class Sesion : NSObject {
    
    static let sesion: Sesion = Sesion()
    
    let api: String = "https://api.weatherbit.io/v2.0"
    let apiKey: String = "6d10afeaa13e4703a95a79547a61c412"
    let lang: String = "es"
    
    var typeDevice: String = ""
    var navigationBarSize: CGFloat = 0
    
    var topPadding:CGFloat = 0
    var bottomPadding:CGFloat = 0
    

    
    class var instance: Sesion {
        return sesion
    }
}

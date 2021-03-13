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
    
    var typeDevice: String = ""
    var navigationBarSize: CGFloat = 0
    
    var topPading:CGFloat = 0
    var bottomPadding:CGFloat = 0
    

    
    class var instance: Sesion {
        return sesion
    }
}

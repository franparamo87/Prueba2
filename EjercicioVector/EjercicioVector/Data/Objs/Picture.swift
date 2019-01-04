//
//  Picture.swift
//  EjercicioVector
//
//  Created by Francisco Paramo Muñoz on 17/6/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class Picture: NSObject {
    var large:String=""
    var thumb:String=""
    
    func initWithParams (large:String, thumb:String) -> Picture {
        self.large = large
        self.thumb = thumb
        return self
    }
}

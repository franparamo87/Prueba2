//
//  player.swift
//  EjercicioHasten
//
//  Created by Francisco Paramo Muñoz on 14/4/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class Player: NSObject {
    var name = ""
    var surname = ""
    var image = ""
    var date = ""
    
    func initWithDic(dic : Dictionary<String, Any>) -> Player{
        name = "\(dic["name"]!)"
        surname = "\(dic["surname"]!)"
        image = "\(dic["image"]!)"
        if dic["date"] != nil {
            date = "\(dic["date"]!)"
        }
        return self
    }
}

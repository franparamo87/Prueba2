//
//  game.swift
//  EjercicioHasten
//
//  Created by Francisco Paramo Muñoz on 14/4/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class Game: NSObject {
    var name = ""
    var listPlayers = [Player]()
    
    func initWithDic(dic : Dictionary<String, Any>) -> Game{
        name = "\(dic["title"]!)"
        return self
    }
}

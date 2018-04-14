//
//  ConnectPlayers.swift
//  EjercicioHasten
//
//  Created by Francisco Paramo Muñoz on 14/4/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ConnectPlayers: ConnectBase {
    var games = [Game]()
    
    func getPlayers() {
        identifier = "players"
        
        super.callWebService(strService: "https://api.myjson.com/bins/66851", params: nil)
    }
    
    override func processJSONResponse(json: Any) {
        let dicJson = json as! [Dictionary<String, Any>]
        
        switch identifier {
        case "players":
            games = [Game]()
            for game in dicJson {
                let gam = Game().initWithDic(dic: game)
                let playersDic = game["players"] as! [Dictionary<String, Any>]
                for player in playersDic{
                    let playr = Player().initWithDic(dic: player)
                    gam.listPlayers.append(playr)
                }
                games.append(gam)
            }
            if self.delegate != nil {
                self.delegate?.handleResult(isOk: true, service: self.identifier, error: nil)
            }
            break
        default:
            break
        }
    }
}

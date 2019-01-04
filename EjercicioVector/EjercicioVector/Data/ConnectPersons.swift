//
//  ConnectPersons.swift
//  EjercicioVector
//
//  Created by Francisco Paramo Muñoz on 17/6/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class ConnectPersons: ConnectBase {
    var persons = [Person]()
    
    func getPersons(page : Int) {
        identifier = "persons"
        
        super.callWebService(strService: "https://randomuser.me/api/?page=\(page)&results=20&gender=female", params: nil)
    }
    
    override func processJSONResponse(json: Any) {
        let dicJson = json as! Dictionary<String, Any>
        let dicResults = dicJson["results"] as! [Dictionary<String, Any>]
        let dicInfo = dicJson["info"] as! Dictionary<String, Any>
        
        switch identifier {
        case "persons":
            if "1" == "\(dicInfo["page"]!)"
            {
                persons = [Person]()
            }
            for person in dicResults {
                let per = Person().initWithDic(dic: person)
                persons.append(per)
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

//
//  Person.swift
//  EjercicioVector
//
//  Created by Francisco Paramo Muñoz on 17/6/18.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit

class Person: NSObject{
    
    var name:String = ""
    var email:String = ""
    var picture:Picture = Picture()
    var cell:String = ""
    
    override init() {
        
    }
    
    func initWithDic (dic : Dictionary<String, Any>) -> Person {
        let name = dic["name"] as! Dictionary<String, Any>
        self.name = "\(name["first"]!) \(name["last"]!)"
        self.cell = "\(dic["cell"]!)"
        self.email = "\(dic["email"]!)"
        let pict = dic["picture"] as! Dictionary<String, Any>
        self.picture = Picture().initWithParams(large: pict["large"] as! String, thumb: pict["thumbnail"] as! String)
        return self
    }
    
    
}


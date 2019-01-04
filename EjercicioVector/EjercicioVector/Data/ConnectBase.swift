//
//  ConnectBase.swift
//
//
//  Created by Francisco Paramo Muñoz.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit
import Alamofire

protocol ConnectBaseDelegate {
    func startService(service:String)
    func handleResult(isOk:Bool, service:String, error:Any?)
}

class ConnectBase: NSObject {
    var baseUrl = ""
    var identifier : String = ""
    var delegate : ConnectBaseDelegate?
    
    let sessionManager = SessionManager()
    
    func cancelAllRequest(){
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({$0.cancel()})
        }
    }
    
    func callWebService(strService : String, params : Dictionary<String,Any>?){
        
        if self.delegate != nil {
            self.delegate?.startService(service: self.identifier)
        }
        
        
        sessionManager.request("\(baseUrl)\(strService)", headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let dicJson = response.result.value as! Dictionary<String, Any>
                    self.processJSONResponse(json: dicJson)
                case .failure(let error):
                    if self.delegate != nil {
                        self.delegate?.handleResult(isOk: false, service: self.identifier, error: error)
                    }
                }
                
        }
    }
    
    func processJSONResponse(json : Any){
        
    }
}

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        self.image = UIImage(named: "no_person")
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}

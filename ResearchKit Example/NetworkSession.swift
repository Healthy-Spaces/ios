//
//  NetworkSession.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 1/31/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import UIKit

class NetworkSession: URLSession {
    
    //let requestURLString = "http://172.16.85.155/"
    //let requestURLString = "http://192.168.0.106/"
    let requestURLString = "http://10.248.210.179/~samuellichlyter/rkebe/"
    
    func dataRequest(with data: Data, completion: @escaping (_ result: String, _ code: Int) -> Void) {
        let url = URL(string: requestURLString)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringCacheData
        
        let dataString = String(data: data, encoding: .utf8)
        let paramString = "data=" + dataString!
        request.httpBody = paramString.data(using: .utf8)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            //print("I'm here!")
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                completion("Network upload error: \(response), \(error)", 1)
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            completion(dataString! as String, 0)
            
        }
        
        task.resume()
    }

}

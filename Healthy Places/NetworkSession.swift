//
//  NetworkSession.swift
//  ResearchKit Example
//
//  Created by Samuel Lichlyter on 1/31/17.
//  Copyright © 2017 Samuel Lichlyter. All rights reserved.
//

import UIKit

class NetworkSession: URLSession {
    
//    let requestURLString = "http://24.20.231.41/~samuellichlyter/healthyplaces/"                  // <-- localhost (Home)
//    let requestURLString = "http://10.0.0.252/~samuellichlyter/healthyplaces/"                    // <-- localhost (A)
//    let requestURLString = "http://10.248.180.15/~samuellichlyter/healthyplaces/"                 // <-- localhost (OSU)
//    let requestURLString = "http://192.168.0.108/"                                                // <-- VMWare Server (Home)
//    let requestURLString = "http://10.0.0.78/"                                                    // <-- VMWare Server (A)
//    let requestURLString = "http://10.248.180.119/"                                               // <-- VMWare Server (OSU)

    let requestURLString = "http://128.193.11.195/"                                               // <-- HHS Server
    
    func dataRequest(with data: Data, completion: @escaping (_ result: String, _ code: Int) -> Void) {
        let url = URL(string: requestURLString)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringCacheData
        
        // Encrypt Data
        let cipherdata = RNCryptor.encrypt(data: data, withPassword: password)
        let cipherString = cipherdata.base64EncodedString()
        let urlString = cipherString.addingPercentEncoding(withAllowedCharacters: .urlPasswordAllowed)
        
        let paramString = "data=" + urlString!
        request.httpBody = paramString.data(using: .utf8)
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                completion("Network upload error: \(String(describing: response)), \(String(describing: error))", 1)
                return
            }
            
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            completion(dataString! as String, 0)
            
        }
        
        task.resume()
    }

}

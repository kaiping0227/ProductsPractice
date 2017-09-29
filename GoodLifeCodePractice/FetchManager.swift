//
//  FetchManager.swift
//  GoodLifeCodePractice
//
//  Created by Francis Tseng on 2017/9/28.
//  Copyright © 2017年 Francis Tseng. All rights reserved.
//

import Foundation
import Alamofire

class FetchManager {
    
    func fetchToken(_ code: String) {

        let parameters = [
            "grant_type":"authorization_code",
            "code": code,
            "client_id": OAuth.clientID.rawValue,
            "client_secret": OAuth.clientSecret.rawValue,
            "redirect_uri": OAuth.redirectUri.rawValue
        ]
        
        //create the url with URL
        let url = URL(string: "http://api.igoodtravel.com/oauth/token")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
            print(data)
        })
        task.resume()
        
        

        
        
        
        
    }
}

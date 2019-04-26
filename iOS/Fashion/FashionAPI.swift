//
//  FashionAPI.swift
//  Fashion
//
//  Created by Junlan Lu on 4/17/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import Foundation
class FashionAPI{
    func postStyleInfo(style: String) {
        print("PRINT here: --in api")
        let json: [String: Any] = [
            "race": style
        ]
        var urlComponents = URLComponents(string: "http://54.189.198.193:4000/v1/prediction")!
        let queryItems = [
            URLQueryItem(name:"race", value:style)
            ]
        urlComponents.queryItems = queryItems
        let url = urlComponents.url
        connectServer(url: url as! URL)
    }
    
    func postLikedItems(userId: String, clothId: String) {
        let json: [String: Any] = [
            "userId": userId,
            "clothId": clothId
        ]
        var urlComponents = URLComponents(string: "http://localhost:4000/v1/addLike")!
        let queryItems = [
            URLQueryItem(name:"userId", value:userId),
            URLQueryItem(name:"clothId", value:clothId)
        ]
        urlComponents.queryItems = queryItems 
        let url = urlComponents.url
        print("\(url) is url")
        connectServer(url: url as! URL)
    }
    
    func postAddCartItems(userId: String, clothId: String) {
        let json: [String: Any] = [
            "userId": userId,
            "clothId": clothId
        ]
        var urlComponents = URLComponents(string: "http://localhost:4000/v1/addCart")!
        let queryItems = [
            URLQueryItem(name:"userId", value:userId),
            URLQueryItem(name:"clothId", value:clothId)
        ]
        urlComponents.queryItems = queryItems
        let url = urlComponents.url
        print("\(url) is url")
        connectServer(url: url as! URL)
    }
    
    
    func connectServer(url: URL){
        URLSession.shared.dataTask(with:url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "err")
            } else{
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    print("pending \(parsedData)")
                    let data = parsedData["data"] as? [String:Any]
                }catch let error as NSError {
                    print(error)
                }
                }
        }.resume()
    }
}

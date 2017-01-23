//
//  NetworkService.swift
//  firstProject
//
//  Created by James Yorke on 20/01/2017.
//  Copyright © 2017 James Yorke. All rights reserved.
//

import UIKit

typealias payload = [String: Any]

class NetworkService: NSObject {

    var names: [String] = []
    
    var prices: [Int] = []
    
    override init() {
        super.init()
        
        let urlString = "https://api.qwertyuiop.net-a-porter.com/TON/GB/en/20/0/summaries?brandIds=291&visibility=visible"
//        let urlString = "https://api.net-a-porter.com/TON/GB/en/20/0/summaries?brandIds=291&visibility=visible"

        let url = URL(string: urlString)!
        
        self.callNetwork(with: url)
    }
    
    func callNetwork(with url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            var jsonData = data
            
            if let error = error {
                print(error)
                let localData: Data? = self.getJsonLocally()
                
                if nil == jsonData {
                    jsonData = localData
                }
            }

            if let uwData = jsonData {
                let json = try? JSONSerialization.jsonObject(with: uwData, options: []) as! payload
                guard json != nil else { return }
                
                self.parseJsonData(json!)
            }
            
            if self.names.count == self.prices.count {
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
            
        }.resume()


    }
    
    func parseJsonData(_ json: payload) {
        
        guard let summaries = json["summaries"] as? [payload] else { return }
        
        
        for summary in summaries {
            
            guard let name = summary["name"] as? String, let price = summary["price"] as? payload, let amount = price["amount"] as? Int else { return }
            
            self.names.append(name)
            self.prices.append(amount)
        }
        
    }
    
    func getJsonLocally() -> Data? {
        if let path = Bundle.main.path(forResource: "summaries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return data
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
}


//
//  NetworkService.swift
//  firstProject
//
//  Created by James Yorke on 20/01/2017.
//  Copyright © 2017 James Yorke. All rights reserved.
//

import UIKit

typealias payload = [String: Any]

class NetworkService {

    static let sharedInstance = NetworkService()

    var model: DataModel? = nil
    var delegate: addDataToStoreDelegate?
    
    var url:URL?
    
    let urlString = "https://api.net-a-porter.com/TON/GB/en/20/0/summaries?brandIds=291&visibility=visible"
    
    private init() {
        print("service init")
    }
    
    func startService(completion: @escaping (_ success:Bool) -> Void) {
        model = DataModel.sharedInstance

        url = URL(string: urlString)
        if let url = url {
            self.callNetwork(with: url) { _ in
                completion(true)
            }
        } else {
            completion(false)
        }
    }
    
    func callNetwork(with url: URL, completion: @escaping (() -> Void)) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            var jsonData = data
            
            if let error = error {
                print(error)
                
                //Error - URL invalid - get JSON from local source instead
                let localData: Data? = self.getJsonLocally()
                
                if nil == jsonData {
                    jsonData = localData
                }
            }

            if let uwData = jsonData {
                let json = try? JSONSerialization.jsonObject(with: uwData, options: []) as! payload
                guard json != nil else { return }
                
                self.parseJsonData(json!)
                completion()
            }
        }.resume()


    }
    
    func parseJsonData(_ json: payload) {
        
        guard let summaries = json["summaries"] as? [payload] else { return }
        
        for summary in summaries {
            
            guard let name = summary["name"] as? String, let price = summary["price"] as? payload, let amount = price["amount"] as? Int else {
                return
            }
            delegate?.addName(name: name)
            delegate?.addPrice(priceInt: amount)
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


protocol addDataToStoreDelegate {
    func addName(name: String)
    func addPrice(priceInt: Int)
    
}

//
//  dataModel.swift
//  firstProject
//
//  Created by James Yorke on 03/02/2017.
//  Copyright © 2017 James Yorke. All rights reserved.
//

import UIKit

class DataModel: NSObject, addDataToStoreDelegate {
    
    var service:NetworkService? = nil
    
    static let sharedInstance = DataModel()
    
    var names: [String] = []
    var prices: [String] = []
    
    private override init() {
        super.init()
        print("model init")
        service = NetworkService.sharedInstance
        service?.delegate = self
    }

    
    func addPrice(priceInt: Int) {
        let price = Float(priceInt)/100
        let priceString = String(format: "%.2f", price)
        self.prices.append(priceString)
    }
    
    func addName(name: String) {
        self.names.append(name)
    }

}

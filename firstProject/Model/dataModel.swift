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
    var prices: [Double] = []
    
    private override init() {
        super.init()
        print("model init")
        service = NetworkService.sharedInstance
        service?.delegate = self
    }

    
    func addPrice(priceInt: Int) {
        let price = Double(priceInt/100)
        self.prices.append(price)
    }
    
    func addName(name: String) {
        self.names.append(name)
    }

}

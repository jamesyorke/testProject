//
//  ViewController.swift
//  firstProject
//
//  Created by James Yorke on 20/01/2017.
//  Copyright © 2017 James Yorke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let service = NetworkService.sharedInstance

    let productTableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductTableVC") as! ProductTableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapStartButton(_ sender: UIButton) {
        service.startService() { success in
            guard success else {
                self.view.backgroundColor = UIColor.blue
                return
            }
            
            self.testData()
            
            self.present(self.productTableVC, animated: true, completion: nil)

        }
        
//        let delay = DispatchTime.now() + 2
//        DispatchQueue.main.asyncAfter(deadline: delay) {
//            self.testData()
//        }
//        
    }

    func testData() {
        let model = DataModel.sharedInstance

        print(model.names)
    }
}


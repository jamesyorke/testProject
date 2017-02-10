//
//  ViewController.swift
//  firstProject
//
//  Created by James Yorke on 20/01/2017.
//  Copyright © 2017 James Yorke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    let navigationController = UINavigationController(rootViewController: self)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Initial View"
        
    }

    @IBAction func didTapStartButton(_ sender: UIButton) {
        
        let service = NetworkService.sharedInstance

        service.startService() { success in
            guard success else {
                self.view.backgroundColor = UIColor.red
                return
            }
            
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "SegueIdentifier", sender: self)
            }
            
//            let productTableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"ProductTableVC") as! ProductTableViewController
//            
//            self.present(productTableVC, animated: true, completion: nil)

        }
        
    }
    
//
//    func testData() {
//        let model = DataModel.sharedInstance
//
//        print(model.names)
//    }
}


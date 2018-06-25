//
//  ViewController.swift
//  GRELit
//
//  Created by user138458 on 5/17/18.
//  Copyright © 2018 user138458. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var BritLitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BritLitPress(_ sender: Any) {
        self.performSegue(withIdentifier: "ToBritLit", sender: self)
    }
}


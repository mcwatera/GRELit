//
//  AmericanLitViewController.swift
//  GRELit
//
//  Created by user138458 on 5/23/18.
//  Copyright © 2018 user138458. All rights reserved.
//

import UIKit

class AmericanLitViewController: UIViewController {

    let AmColonial = "The Colonial Period (1607 - 1775)"
    let AmRevolutionary = "The Revolutionary Age (1765 - 1790)"
    let AmEarlyNational = "The Early National Period (1775 - 1828)"
    let AmRenaissance = "The American Renaissance (1828 - 1865)"
    let AmRealism = "The Realistic Period (1865 - 1900)"
    let AmNaturalist = "The Naturalist Period (1900 - 1914)"
    let AmModern = "The Modern Period (1914 - 1939)"
    let AmBeat = "The Beat Generation (1944 - 1962)"
    let AmContemporary = "The Contemporary Period (1939 - Present)"
    let AmOther = "Other Movements in American Literature"
    
    @IBOutlet weak var AmericanPopUp: UITextView!
    
    @IBOutlet var AmericanButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AmericanPopUp.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func AmButtonPress(_ sender: UIButton) {
        let tag = sender.tag
        AmericanShow(tag : tag)
    }
    
    func AmericanShow(tag : Int) {
        if tag == 0 {
            AmericanPopUp.text = AmColonial
            AmericanPopUp.isHidden = false
        } else if tag == 1 {
            AmericanPopUp.text = AmOther
            AmericanPopUp.isHidden = false
        } else if tag == 2 {
            AmericanPopUp.text = AmContemporary
        } else if tag == 3 {
            AmericanPopUp.text = AmNaturalist
            AmericanPopUp.isHidden = false
        } else if tag == 4 {
            AmericanPopUp.text = AmRealism
            AmericanPopUp.isHidden = false
        } else if tag == 5 {
            AmericanPopUp.text = AmEarlyNational
            AmericanPopUp.isHidden = false
        } else if tag == 6 {
            AmericanPopUp.text = AmRenaissance
            AmericanPopUp.isHidden = false
        } else if tag == 7 {
            AmericanPopUp.text = AmRevolutionary
            AmericanPopUp.isHidden = false
        } else if tag == 8 {
            AmericanPopUp.text = AmBeat
            AmericanPopUp.isHidden = false
        } else if tag == 9 {
            AmericanPopUp.text = AmModern
            AmericanPopUp.isHidden = false
        } else if tag == 10 {
            AmericanPopUp.text = "Nothing here yet..."
            AmericanPopUp.isHidden = false
        }
    }
    



}

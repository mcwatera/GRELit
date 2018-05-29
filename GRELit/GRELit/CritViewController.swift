//
//  CritViewController.swift
//  GRELit
//
//  Created by user138458 on 5/22/18.
//  Copyright © 2018 user138458. All rights reserved.
//

import UIKit

class CritViewController: UIViewController {

    let CritGreeks = "Greeks"
    let CritRenaissance = "Renaissance: hermeneutics"
    let CritRussianFormalism = "Russian Formalism"
    let CritNewCriticism = "New Criticism"
    let CritChicago = "The Chicago School"
    let CritUSFormalism = "U.S. Formalism"
    let CritStructuralism = "France, Structuralism"
    let CritDeconstruction = "Deconstruction"
    let CritHistoricism = "New Historicism"
    let CritModern = "Modern Day"
    let CritOther = "Other"
    
    @IBOutlet var CritButtons: [UIButton]!
    
    @IBOutlet weak var CritPopUp: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CritPopUp.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func CritButtonpress(_ sender: UIButton) {
        let tag = sender.tag
        ShowCritPopUp(tag : tag)
    }
    
    func ShowCritPopUp(tag : Int) {
        if tag == 0 {
            CritPopUp.text = CritOther
            CritPopUp.isHidden = false
        } else if tag == 1 {
            CritPopUp.text = CritHistoricism
            CritPopUp.isHidden = false
        } else if tag == 2 {
            CritPopUp.text = CritModern
            CritPopUp.isHidden = false
        } else if tag == 3 {
            CritPopUp.text = CritDeconstruction
            CritPopUp.isHidden = false
        } else if tag == 4 {
            CritPopUp.text = CritStructuralism
            CritPopUp.isHidden = false
        } else if tag == 5 {
            CritPopUp.text = CritNewCriticism
            CritPopUp.isHidden = false
        } else if tag == 6 {
            CritPopUp.text = CritUSFormalism
            CritPopUp.isHidden = false
        } else if tag == 7 {
            CritPopUp.text = CritRussianFormalism
            CritPopUp.isHidden = false
        } else if tag == 8 {
            CritPopUp.text = CritRenaissance
            CritPopUp.isHidden = false
        } else if tag == 9 {
            CritPopUp.text = CritGreeks
            CritPopUp.isHidden = false
        } else if tag == 10 {
            CritPopUp.text = CritChicago
            CritPopUp.isHidden = false
        }
    }
  

}

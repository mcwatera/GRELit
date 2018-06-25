//
//  WorldLitViewController.swift
//  GRELit
//
//  Created by user138458 on 5/23/18.
//  Copyright © 2018 user138458. All rights reserved.
//

import UIKit

class WorldLitViewController: UIViewController {

    @IBOutlet weak var WorldPopUp: UITextView!
    
    @IBOutlet var WorldButtons: [UIButton]!
    
    let WorldGreek = "Ancient Greece"
    let WorldRoman = "Ancient Roman"
    let WorldNative = "Native American"
    let WorldArabic = "Arabic (Middle Eastern)"
    let WorldChinese = "Chinese"
    let WorldRussian = "Russian"
    let WorldJapanese = "Japanese"
    let WorldLatin = "Latin American"
    let WorldAfrican = "African"
    let WorldOther = "Nothing here yet..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WorldPopUp.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func WorldButtonPress(_ sender: UIButton) {
        let tag = sender.tag
        WorldShowPopUp(tag : tag)
    }
    
    
    func WorldShowPopUp(tag : Int) {
        if tag == 0 {
            WorldPopUp.text = WorldGreek
            WorldPopUp.isHidden = false
        } else if tag == 1 {
            WorldPopUp.text = WorldRoman
            WorldPopUp.isHidden = false
        } else if tag == 2 {
            WorldPopUp.text = WorldNative
            WorldPopUp.isHidden = false
        } else if tag == 3 {
            WorldPopUp.text = WorldArabic
            WorldPopUp.isHidden = false
        } else if tag == 4 {
            WorldPopUp.text = WorldChinese
            WorldPopUp.isHidden = false
        } else if tag == 5 {
            WorldPopUp.text = WorldRussian
            WorldPopUp.isHidden = false
        } else if tag == 6  {
            WorldPopUp.text = WorldJapanese
            WorldPopUp.isHidden = false
        } else if tag == 7 {
            WorldPopUp.text = WorldLatin
            WorldPopUp.isHidden = false
        } else if tag == 8 {
            WorldPopUp.text = WorldAfrican
            WorldPopUp.isHidden = false
        } else if tag == 9 {
            WorldPopUp.text = WorldOther
            WorldPopUp.isHidden = false
        } else if tag == 10 {
            WorldPopUp.text = WorldOther
            WorldPopUp.isHidden = false
        }
    }
    

 

}

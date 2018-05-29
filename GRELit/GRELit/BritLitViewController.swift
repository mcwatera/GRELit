
import UIKit

class BritLitViewController: UIViewController {

    var OldEnglishBrit = "Old English (Anglo-Saxon) Period"
    var MiddleEnglishBrit = "Middle English Period"
    var RenaissanceBrit = "The Renaissance"
    var NeoClassicalBrit = "The Neoclassical Period"
    var RomanticBrit = "The Romantic Period"
    var VictorianBrit = "The Victorian Period"
    var EdwardianBrit = "The Edwardian Period"
    var GeorgianBrit = "The Georgian Period"
    var ModernBrit = "The Modern Period"
    var PostModernBrit = "The PostModern Period"
    
    @IBOutlet weak var PopUpBrit: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopUpBrit.isHidden = true
        
    }

    @IBOutlet var BritButtons: [UIButton]!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func BritButtonPush(_ sender: UIButton) {
        let tag = sender.tag
        ShowPopUpBrit(tag : tag)
    }
    
    func ShowPopUpBrit(tag : Int) {
        if tag == 0 {
            PopUpBrit.text = "What?"
            PopUpBrit.isHidden = true
        } else if tag == 1 {
            PopUpBrit.text = GeorgianBrit
            PopUpBrit.isHidden = false
        } else if tag == 2 {
            PopUpBrit.text = RomanticBrit
            PopUpBrit.isHidden = false
        } else if tag == 3 {
            PopUpBrit.text = NeoClassicalBrit
            PopUpBrit.isHidden = false
        } else if tag == 4 {
            PopUpBrit.text = RenaissanceBrit
            PopUpBrit.isHidden = false
        } else if tag == 5 {
            PopUpBrit.text = MiddleEnglishBrit
            PopUpBrit.isHidden = false
        } else if tag == 6 {
            PopUpBrit.text = OldEnglishBrit
            PopUpBrit.isHidden = false
        } else if tag == 7 {
            PopUpBrit.text = VictorianBrit
            PopUpBrit.isHidden = false
        } else if tag == 8 {
            PopUpBrit.text = EdwardianBrit
            PopUpBrit.isHidden = false
        } else if tag == 9 {
            PopUpBrit.text = PostModernBrit
            PopUpBrit.isHidden = false
        } else if tag == 10 {
            PopUpBrit.text = ModernBrit
            PopUpBrit.isHidden = false
        }
        
    }


}

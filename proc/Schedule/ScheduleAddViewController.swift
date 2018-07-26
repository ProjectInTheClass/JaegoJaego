import UIKit
import Foundation

class ScheduleAddViewController : UIViewController {
    
   
    
    //@IBOutlet weak var btnComplete:UIButton!
    @IBOutlet weak var Eventbutton: RadioButton!
    @IBOutlet weak var Reservebutton: RadioButton!
    @IBOutlet weak var rename: UITextField!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var okbutton: UIButton!
  
    @IBAction func complete(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func eventbutton(_ sender: AnyObject) {
        
    }
    
    
}


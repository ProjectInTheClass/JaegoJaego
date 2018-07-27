import UIKit
import Foundation

class ScheduleAddViewController : UIViewController, UITextFieldDelegate {
    
  
    
    //@IBOutlet weak var btnComplete:UIButton!
  
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var textV: UITextView!
    @IBOutlet weak var okbutton: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func complete(_ sender: AnyObject) {
        var eventArray : [Event] = []
        
        var eventname = name.text!
        var text = textV.text!

        eventArray.append(Event(eventname: eventname, text: text))
        print(eventArray)
        
        self.dismiss(animated: true, completion: nil)

    }

}


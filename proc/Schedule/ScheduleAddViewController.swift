import UIKit
import Foundation

class ScheduleAddViewController : UIViewController, UITextFieldDelegate {
  
    var eventArray : [Event] = []
    //@IBOutlet weak var btnComplete:UIButton!
  
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var textV: UITextView!
    @IBOutlet weak var okbutton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func complete(_ sender: AnyObject) {
        
        
        var eventname = name.text!
        var text = textV.text!

        eventArray.append(Event(eventname: eventname, text: text))
        print(eventArray)

        func complete (_ sender: AnyObject) {
        // 값 받는 코드

        self.dismiss(animated: true, completion: nil)

        }

    }

}

import UIKit
import Foundation

class ScheduleAddViewController : UIViewController, UITextFieldDelegate {
  
    var eventArray : [Event] = []
    //@IBOutlet weak var btnComplete:UIButton!
  
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var textV: UITextView!
    @IBOutlet weak var okbutton: UIButton!
    
    @IBOutlet weak var alarm1: UILabel!
    @IBOutlet weak var alarm2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarm1.text = " "
        alarm2.text = " "
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
    }
    
    //키보드 엔터키 누르면 키보드 내려감
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func complete(_ sender: AnyObject) {
        
        
        var eventname = name.text!
        var text = textV.text!
        
        
        // 빈칸 처리문
        if( eventname == ""){
            alarm1.text = "값이 없습니다"
        }
        else{
            alarm1.text = " "
        }
        if( text == ""){
            alarm2.text = "값이 없습니다"
        }
        else{
            alarm2.text = "  "
        }
        if( eventname != "" && text != "" ){
            
            eventArray.append(Event(eventname: eventname, text: text))
            print(eventArray)
        }


        func complete (_ sender: AnyObject) {
        // 값 받는 코드

            self.dismiss(animated: true, completion: nil)
        }

    }

}

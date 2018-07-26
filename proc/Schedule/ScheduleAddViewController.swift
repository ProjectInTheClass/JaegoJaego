import UIKit
import Foundation

class ScheduleAddViewController : UIViewController {
    @IBOutlet weak var btnComplete:UIButton!
    
    @IBAction func complete (_ sender: AnyObject) {
        // 값 받는 코드
        
        
        self.dismiss(animated: true, completion: nil)
    }
}

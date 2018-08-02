import Foundation
import UIKit

// 뒤로가는 클래스
class CompleteViewController : UIViewController{
    
    @IBAction func touchBack (_ sender: Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
}

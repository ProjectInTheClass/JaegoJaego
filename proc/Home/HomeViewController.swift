 
 import UIKit
 import Foundation
 import FSCalendar
 
 class HomeViewController: UIViewController {
    
    // 오늘의 날짜
    @IBOutlet weak var TodayDate :UILabel?

   
    func dateformatting() -> String{
        let formatter = DateFormatter()
        let formatterdate = Date()
        
        formatter.dateFormat = "MM월 dd일"
        
        let todayDate = formatter.string(from: formatterdate)
        return todayDate
    }
    
    
    
    override func viewDidLoad() {
        TodayDate?.text! = dateformatting()
    }
}

    

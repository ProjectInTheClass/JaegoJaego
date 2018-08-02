 
 import UIKit
 import Foundation
 import FSCalendar
 
 class HomeViewController: UIViewController {
    
    // 오늘의 날짜
    @IBOutlet weak var TodayDate :UILabel?
    
    
    // 오늘 날짜 기준 -3일 ~ +3일
    @IBOutlet weak var dayLbl1: UILabel!
    @IBOutlet weak var dayLbl2: UILabel!
    @IBOutlet weak var dayLbl3: UILabel!
    @IBOutlet weak var dayLbl4: UILabel!
    @IBOutlet weak var dayLbl5: UILabel!
    @IBOutlet weak var dayLbl6: UILabel!
    @IBOutlet weak var dayLbl7: UILabel!
    
    
    override func viewDidLoad() {
        
        
        
        let Today = HomeDateModel.dateInfo()
        
        // 오늘 날짜 기준 -3일 ~ +3일
        let infoDates = HomeDateModel.dateInfo()
        let infoToday = HomeDateModel.todayDateInfo()
        let infoToday1 = HomeDateModel.todayDateInfo1()
        let infoToday2 = HomeDateModel.todayDateInfo2()
        let infoToday3 = HomeDateModel.todayDateInfo3()
        let infoToday5 = HomeDateModel.todayDateInfo5()
        let infoToday6 = HomeDateModel.todayDateInfo6()
        let infoToday7 = HomeDateModel.todayDateInfo7()
        
        
        if let date:String = Today {
            TodayDate?.text = Today
        }
        
        dayLbl1?.text = infoToday1
        dayLbl2?.text = infoToday2
        dayLbl3?.text = infoToday3
        dayLbl4?.text = infoToday
        dayLbl5?.text = infoToday5
        dayLbl6?.text = infoToday6
        dayLbl7?.text = infoToday7
        
        
    }
 }

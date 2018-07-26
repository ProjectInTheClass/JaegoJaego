

//import JTAppleCalendar
import UIKit
import Foundation
import FSCalendar

class ScheduleViewController :UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var todayDate :UILabel?
    
//    let scheduleDate = HomeViewController.dateInfo_Date()
//    
//    if let date = scheduleDate {
//        todayDate?.text = scheduleDate
//        
//    }
    
    @IBOutlet weak var ourCalendar: FSCalendar!

    //let newCalendar = FSCalendar().
    
//    @IBAction func tempbutton(_ sender: AnyObject){
//        print(newCalendar)
//    }
}

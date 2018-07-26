

//import JTAppleCalendar
import UIKit
import Foundation
import FSCalendar

class ScheduleViewController :UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var todayDate :UILabel?
    @IBOutlet weak var ourCalendar: FSCalendar!

}

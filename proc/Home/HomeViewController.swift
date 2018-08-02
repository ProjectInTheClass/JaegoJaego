//
//  HomeViewController.swift
//  proc
//
//  Created by swuad_22 on 2018. 7. 19..
//  Copyright © 2018년 swuad-19. All rights reserved.
//


import UIKit
import Foundation
import FSCalendar

let scheduleModel = ScheduleDatabase
var tdate = ""

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
    
    //button
    @IBOutlet weak var dayBut1: UIButton!
    @IBOutlet weak var dayBut2: UIButton!
    @IBOutlet weak var dayBut3: UIButton!
    @IBOutlet weak var dayBut4: UIButton!
    @IBOutlet weak var dayBut5: UIButton!
    @IBOutlet weak var dayBut6: UIButton!
    @IBOutlet weak var dayBut7: UIButton!
    

//    @IBAction func button(_ sender: UIButton) {
//        switch sender.tag {
//        case 0:
//            tdate = HomeDateModel.todayDateInfo1()
//        case 1:
//            tdate = HomeDateModel.todayDateInfo2()
//        case 2:
//            tdate = HomeDateModel.todayDateInfo3()
//        case 3:
//            tdate = HomeDateModel.dateInfo()
//        case 4:
//            tdate = HomeDateModel.todayDateInfo5()
//        case 5:
//            tdate = HomeDateModel.todayDateInfo6()
//        case 6:
//            tdate = HomeDateModel.todayDateInfo7()
//        default:
//            print("!")
//        }
//        performSegue(withIdentifier: "buttonevent", sender: sender)
//    }
//
//    
//    
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        //let cell = sender as! UITableViewCell
//        //        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
//        //
//        //        self.ThrowArrayModel.selectedIndex = indexPath.row
//        //
//        let view = segue.destination as! HomeScheduleTableViewController
//        view.sameDate = tdate
//
//    }
//    
    
    
    override func viewDidLoad() {
        
        let Today = HomeDateModel.dateInfo()
        
        // 오늘 날짜 기준 -3일 ~ +3일
        //        let infoDates = HomeDateModel.dateInfo()
        //        let infoToday = HomeDateModel.todayDateInfo()
        //        let infoToday1 = HomeDateModel.todayDateInfo1()
        //        let infoToday2 = HomeDateModel.todayDateInfo2()
        //        let infoToday3 = HomeDateModel.todayDateInfo3()
        //        let infoToday5 = HomeDateModel.todayDateInfo5()
        //        let infoToday6 = HomeDateModel.todayDateInfo6()
        //        let infoToday7 = HomeDateModel.todayDateInfo7()
        
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
        
        //        dayLbl1?.text = infoToday1
        //        dayLbl2?.text = infoToday2
        //        dayLbl3?.text = infoToday3
        //        dayLbl4?.text = infoToday
        //        dayLbl5?.text = infoToday5
        //        dayLbl6?.text = infoToday6
        //        dayLbl7?.text = infoToday7
        
        dayBut1? .setTitle(infoToday1, for: .normal)
        dayBut2? .setTitle(infoToday2, for: .normal)
        dayBut3? .setTitle(infoToday3, for: .normal)
        dayBut4? .setTitle(infoToday, for: .normal)
        dayBut5? .setTitle(infoToday5, for: .normal)
        dayBut6? .setTitle(infoToday6, for: .normal)
        dayBut7? .setTitle(infoToday7, for: .normal)
        
    }
}

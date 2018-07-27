//
//  ScheduleTableViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 24..
//  Copyright © 2018년 swuad-19. All rights reserved.
//
import UIKit
import Foundation

// 색상 지정 함수
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

struct Colors {
    static var darkGreen = UIColor(red: 46, green: 204, blue: 113)
    static var darkBlue = UIColor(red: 52, green: 152, blue: 219)
}


class ScheduleTableViewController : UITableViewController{
    static var ModelSchedule = ScheduleModel()
    
    // 출력하는 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return ScheduleTableViewController.ModelSchedule.ScheduleArray.count
        //self.ModelSchedule.ScheduleArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let scheduleInfo = ScheduleTableViewController.ModelSchedule.ScheduleArray[indexPath.row]
        let ScheduleCell:ScheduleChartCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleChartCell
        
        
        ScheduleCell.scheduleTitle.text = scheduleInfo.title + " 시"
        ScheduleCell.scheduleMemo.text = scheduleInfo.memo
        ScheduleCell.scheduleMemo.textColor = UIColor.gray
        //ScheduleCell.scheduleCount.text = "No. " + String(scheduleInfo.counts)
        
        return ScheduleCell
    }

//    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//        let cell = sender as! UITableViewCell
//        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
//        let segueStore = segue.destination as! ScheduleTableViewController
//        ScheduleTableViewController.segueStore.ModelSchedule = ScheduleTableViewController.ModelSchedule
//    }
}

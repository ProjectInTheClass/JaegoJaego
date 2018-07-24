//
//  ScheduleTableViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 24..
//  Copyright © 2018년 swuad-19. All rights reserved.
//
import UIKit
import Foundation

struct Colors{
    static var darkGreen = UIColor(named: "darkGreen")
    static var darkBlue = UIColor(named: "darkBlue")
}

enum scheduleStyle: String {
    case reservation = "예약"
    case event = "이벤트"
}

struct Schedule {
    var title: String
    var memo: String
    var style: scheduleStyle
    
    init(title:String, memo:String,style:scheduleStyle) {
        self.title = title
        self.memo = memo
        self.style = style
    }
}

struct ScheduleModel {
     var ScheduleArray:Array <Schedule>
    
    init(){
        self.ScheduleArray = []
        
        var stock =  Schedule(title:"2시 예약", memo:"태권도팀 30명", style: .reservation)
        self.ScheduleArray.append(stock)
        stock =  Schedule(title:"5시 예약", memo:"삼성전자 단체회식 40명", style: .event)
        self.ScheduleArray.append(stock)
        stock =  Schedule(title:"12시 예약", memo:"일반 8인", style: .reservation)
        self.ScheduleArray.append(stock)
        stock =  Schedule(title:"11시 예약", memo:"12명", style: .event)
        self.ScheduleArray.append(stock)
    }
    
}


class ScheduleTableViewController : UITableViewController{
    var ModelSchedule = ScheduleModel()
    
    // 출력하는 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return self.ModelSchedule.ScheduleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let scheduleInfo = self.ModelSchedule.ScheduleArray[indexPath.row]
        let ScheduleCell:ScheduleChartCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleChartCell
        
        ScheduleCell.scheduleTitle.text = scheduleInfo.title
        ScheduleCell.scheduleMemo.text = scheduleInfo.memo
        ScheduleCell.scheduleEvent.text = scheduleInfo.style.rawValue
        return ScheduleCell
    }

    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        let segueStore = segue.destination as! ScheduleTableViewController
        segueStore.ModelSchedule = self.ModelSchedule
    }
}

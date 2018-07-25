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




enum scheduleStyle: String {
    case reservation = "예약"
    case event = "이벤트"
}

// 일정 데이터 정의
struct Schedule {
    var title: Int
    var memo: String
    var style: scheduleStyle
    var counts:Int = 1
    
    init(title:Int, memo:String,style:scheduleStyle, counts:Int) {
        self.title = title
        self.memo = memo
        self.style = style
        self.counts = counts
    }
}

// 일정 배열 <일정 데이터>
struct ScheduleModel {
     var ScheduleArray:Array <Schedule>
    
    init(){
        // 예약 시간에 따른 정렬 (1시  2시  5시 순)
        // 순서에 따른 count 값
        
        self.ScheduleArray = []
        var stock =  Schedule(title: 14, memo:"태권도팀 30명", style: .reservation, counts: 1)
        self.ScheduleArray.append(stock)
        stock =  Schedule(title: 17, memo:"삼성전자 단체회식 40명", style: .event, counts: 1)
        self.ScheduleArray.append(stock)
        stock =  Schedule(title: 12, memo:"일반 8인", style: .reservation, counts:  1)
        self.ScheduleArray.append(stock)
        stock =  Schedule(title: 11, memo:"12명", style: .event, counts:  1)
        self.ScheduleArray.append(stock)
    
        var sortedSchedule = self.ScheduleArray.sorted(by: { $0.title < $1.title} )
        
        for i in 0..<ScheduleArray.count {
            sortedSchedule[i].counts += i
        }
         ScheduleArray = sortedSchedule
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
        //self.ModelSchedule.ScheduleArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let scheduleInfo = self.ModelSchedule.ScheduleArray[indexPath.row]
        let ScheduleCell:ScheduleChartCell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleChartCell
        
        
        ScheduleCell.scheduleTitle.text = String(scheduleInfo.title) + " 시"
        ScheduleCell.scheduleMemo.text = scheduleInfo.memo
        ScheduleCell.scheduleMemo.textColor = UIColor.gray
        ScheduleCell.scheduleEvent.text = scheduleInfo.style.rawValue
        
        
        // 예약, 이벤트별 폰트 색상 변경
        if scheduleInfo.style.rawValue == scheduleStyle.reservation.rawValue {
            ScheduleCell.scheduleEvent.textColor = Colors.darkGreen
        }else {
            ScheduleCell.scheduleEvent.textColor = Colors.darkBlue
        }
        
        
        ScheduleCell.scheduleCount.text = "No. " + String(scheduleInfo.counts)
        
        
        
        return ScheduleCell
    }

    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        let segueStore = segue.destination as! ScheduleTableViewController
        segueStore.ModelSchedule = self.ModelSchedule
    }
}

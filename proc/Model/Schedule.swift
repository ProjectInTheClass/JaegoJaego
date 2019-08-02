//
//  Schedule.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import Foundation

// 일정 데이터 저장소
let ScheduleDatabase = ScheduleModel()
let projectName = "JaegoJaego"
let scheduleFileName = "JaegoSchedule.file"
let dateArrayFileName = "JaegoScheduleDateArray.file"

// 일정 데이터 정의
class Schedule : NSObject, NSCoding {
    
    var memotitle: String // 메모
    //var memotime: String // 시간
    var memodates: String // 달력과 비교할 날짜
    
    //  var counts:Int 는 셀의 개수로 넣음
    let key =  Date().timeIntervalSince1970
    static func == (lhs: Schedule  , rhs: Schedule) -> Bool {
        return lhs.key == rhs.key
    }
    
    init(memotitle:String,  memodates:String) {
        self.memotitle = memotitle
        self.memodates = memodates
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.memotitle, forKey: "memotitle")
        aCoder.encode(self.memodates, forKey: "memodates")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.memotitle = aDecoder.decodeObject(forKey: "memotitle") as! String
        self.memodates = aDecoder.decodeObject(forKey: "memodates") as! String
    }
}

// 일정 배열 <일정 데이터>
class ScheduleModel {
    var ScheduleArray: [Schedule] = []
    var dateArray = [String]()
    
    var schedulfilepath : String {get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + projectName + "/" + scheduleFileName
        }}
    var datefilepath : String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + projectName + "/" + dateArrayFileName
        }}
    
    func saveData(){
        NSKeyedArchiver.archiveRootObject(self.ScheduleArray, toFile: self.schedulfilepath)
        NSKeyedArchiver.archiveRootObject(self.dateArray, toFile: self.datefilepath)
    }
    
    
    
    func scheduleDefaultData() -> Array<Schedule>{
      
        let stock1 =  Schedule(memotitle: "예약 2팀", memodates:"20190721")
        let stock2 =  Schedule(memotitle: "예약 4팀", memodates:"20190722")
        let stock3 =  Schedule(memotitle: "순두부 추가 주문", memodates:"20190826")
        let stock4 =  Schedule(memotitle: "예약 7팀", memodates:"20190725")
        let stock5 =  Schedule(memotitle: "핫도그 재고 드랍", memodates:"20190730")
        let stock6 =  Schedule(memotitle: "예약 5팀", memodates:"20190826")
        let stock7 =  Schedule(memotitle: "예약 2팀", memodates:"20190824")
        return [stock1, stock2, stock3, stock4, stock5, stock6,stock7]
    }
    func datearrayDefaultData() -> Array<String>{
        let stock1 =  Schedule(memotitle: "예약 2팀", memodates:"20190721")
        let stock2 =  Schedule(memotitle: "예약 4팀", memodates:"20190722")
        let stock3 =  Schedule(memotitle: "순두부 추가 주문", memodates:"20190826")
        let stock4 =  Schedule(memotitle: "예약 7팀", memodates:"20190725")
        let stock5 =  Schedule(memotitle: "핫도그 재고 드랍", memodates:"20190730")
        let stock6 =  Schedule(memotitle: "예약 5팀", memodates:"20190826")
        let stock7 =  Schedule(memotitle: "예약 2팀", memodates:"20190824")
         return [stock1.memodates,stock2.memodates,stock3.memodates,stock4.memodates,stock5.memodates,stock6.memodates,stock7.memodates]
    }
    
    init(){
        if FileManager.default.fileExists(atPath: self.schedulfilepath){
            if let scheduleArrayList = NSKeyedUnarchiver.unarchiveObject(withFile: self.schedulfilepath) as? [Schedule] {
                ScheduleArray = scheduleArrayList
            }
        } else { ScheduleArray = scheduleDefaultData()}
        
        if FileManager.default.fileExists(atPath: self.datefilepath){
            if let dateArrayList = NSKeyedUnarchiver.unarchiveObject(withFile: self.datefilepath) as? [String] {
                dateArray = dateArrayList
            }
        } else { dateArray = datearrayDefaultData()}
    }
}

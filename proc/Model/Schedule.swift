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

// 일정 데이터 정의
class Schedule :Equatable {
    var memotitle: String // 메모
    var memotime: String // 시간
    var memodates: String // 달력과 비교할 날짜
    
    //  var counts:Int 는 셀의 개수로 넣음
    let key =  Date().timeIntervalSince1970
    
    static func == (lhs: Schedule  , rhs: Schedule) -> Bool {
        return lhs.key == rhs.key
    }
    
    init(memotitle:String, memotime:String, memodates:String) {
        self.memotitle = memotitle
        self.memotime = memotime
        self.memodates = memodates
    }
}

// 일정 배열 <일정 데이터>
class ScheduleModel {
    var ScheduleArray: [Schedule] = []
    var dateArray = [String]()
    init(){
        // 예약 시간에 따른 정렬 (1시  2시  5시 순)
        // 순서에 따른 count 값
        let stock1 =  Schedule(memotitle: "예약 2팀",memotime: "02:40 pm", memodates:"20190121")
        let stock2 =  Schedule(memotitle: "예약 4팀",memotime: "05:30 pm", memodates:"20190122")
        let stock3 =  Schedule(memotitle: "예약 5팀",memotime: "09:20 am", memodates:"20190121")
        let stock4 =  Schedule(memotitle: "예약 7팀",memotime: "11:00 am", memodates:"20190125")
        let stock5 =  Schedule(memotitle: "예약 4팀",memotime: "05:00 pm", memodates:"20190130")
        let stock6 =  Schedule(memotitle: "예약 5팀",memotime: "09:30 am", memodates:"20190126")
        let stock7 =  Schedule(memotitle: "예약 2팀",memotime: "02:20 pm", memodates:"20190124")
        self.ScheduleArray += [stock1, stock2, stock3, stock4, stock5, stock6,stock7]
        self.dateArray += [stock1.memodates,stock2.memodates,stock3.memodates,stock4.memodates,stock5.memodates,stock6.memodates,stock7.memodates]
    }
    
}

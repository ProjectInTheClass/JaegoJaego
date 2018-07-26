//
//  ScheduleDataModel.swift
//  proc
//
//  Created by swuad_16 on 2018. 7. 26..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import Foundation
import UIKit

struct Event { //이벤트
    var eventname: String //제목
    var period: String //기간
    var text: String //내용
    
    
    // 이벤트 생성자
    init(eventname:String, period:String, text:String ){
        self.eventname = eventname
        self.period = period
        self.text = text
    }
}

struct reservation { //예약
    var time: String //시간
    var name: String //이름
    var people: Int //인원수
    var number: Int //예약자번호
    
    // 예약 생성자
    init(time:String, name:String, people:Int, number:Int ){
        self.time = time
        self.name = name
        self.people = people
        self.number = number
    }
}


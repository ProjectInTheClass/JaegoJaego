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
    var eventname: String? //제목
    var text: String? //내용
    
    
    // 이벤트 생성자
    init(eventname:String, text:String ){
        self.eventname = eventname 
        self.text = text
    }
}



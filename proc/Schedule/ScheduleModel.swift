import UIKit
import Foundation

// 일정 데이터 저장소
let model = ScheduleModel()

// 일정 데이터 정의
struct Schedule {
    var title: String
    var memo: String
    //  var counts:Int = 1
    var dates:String
    
    init(title:String, memo:String, dates: String) {
        self.title = title
        self.memo = memo
        //    self.counts = counts
        self.dates = dates
    }
}


// 일정 배열 <일정 데이터>
class ScheduleModel {
    var ScheduleArray: [Schedule] = []
    
    init(){
        // 예약 시간에 따른 정렬 (1시  2시  5시 순)
        // 순서에 따른 count 값
        
        let stock1 =  Schedule(title: "예약", memo:"태권도팀 30명", dates: "20180814")
        let stock2 =  Schedule(title: "예약", memo:"삼성전자 단체회식 40명", dates: "20180816")
        let stock3 =  Schedule(title: "메모", memo:"일반 8인", dates: "20180815")
        let stock4 =  Schedule(title: "어린이", memo:"12명", dates: "20180813")
        self.ScheduleArray += [stock1, stock2, stock3, stock4]

    }
    
   
    
}

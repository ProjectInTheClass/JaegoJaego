import UIKit
import Foundation

// 폐기 목록 데이터 타입 정의
struct HomeThrowChart {
    var processImage: String?
    var name :String
    var saveStyle : saveStyle
    var many: Int = 1
    var manyType: String
    
    init(name:String, many: Int, saveStyle:saveStyle, manyType:String){
        self.name = name
        self.many = many
        self.saveStyle = saveStyle
        self.manyType = manyType
    }
}

// 폐기 데이터 배열 생성
class HomedisposalChart_Model {
    var selectedIndex:Int = 0
    var HomeThrowArray:Array <HomeThrowChart>
    
    init() {
        self.HomeThrowArray = []
        
        var throwItem = HomeThrowChart(name: "바나나", many: 20, saveStyle: .Cold, manyType: "개수")
        self.HomeThrowArray.append(throwItem)
        
        throwItem = HomeThrowChart(name: "아보카도", many: 10, saveStyle: .Cold, manyType: "박스")
        self.HomeThrowArray.append(throwItem)
        
        // 수량 순으로 정렬
        let sortedThrowItem = self.HomeThrowArray.sorted(by: { $0.many > $1.many})
        HomeThrowArray = sortedThrowItem
    }
    
}

class HomeDateModel {
  /** 오늘 날짜 출력하는 클래스
 */
    //오늘 날짜 구하는 함수. 년, 월, 일
    static func dateInfo()-> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
        
    }
    
    static func todayDateInfo() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        
        todayformatter.dateFormat = "dd"
        let stringToday = todayformatter.string(from: todaydate)
        return stringToday
    }
    
    let infoDate:String = HomeDateModel.dateInfo()
    let infoToday:String = HomeDateModel.todayDateInfo()
}

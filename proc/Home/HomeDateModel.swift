import UIKit
import Foundation

// 폐기 목록 데이터 타입 정의
struct HomeThrowChart {
    
    var processImage: String?
    var name :String
    var saveStyle : saveStyle
    var many: Int = 0
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
        
        dateFormatter.dateFormat = "dd"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
        
    }

    let infoDate = HomeDateModel.dateInfo()
    
    
// 오늘을 기준으로 -3, +3 날짜 구하기
    
    static func todayDateInfo() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        
        
        todayformatter.dateFormat = "dd"
        let stringToday = todayformatter.string(from: todaydate)
        return stringToday
    }
    
    static func todayDateInfo1() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        let today1 = todaydate - 86400 * 3
        
        todayformatter.dateFormat = "dd"
        let stringToday1 = todayformatter.string(from: today1)
        return stringToday1
    }
    
    static func todayDateInfo2() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        let today2 = todaydate - 86400 * 2
        
        todayformatter.dateFormat = "dd"
        let stringToday2 = todayformatter.string(from: today2)
        return stringToday2
    }
    
    static func todayDateInfo3() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        let today3 = todaydate - 86400
        
        todayformatter.dateFormat = "dd"
        let stringToday3 = todayformatter.string(from: today3)
        return stringToday3
    }
    
    static func todayDateInfo5() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        let today5 = todaydate + 86400
        
        todayformatter.dateFormat = "dd"
        let stringToday5 = todayformatter.string(from: today5)
        return stringToday5
    }
    
    static func todayDateInfo6() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        let today6 = todaydate + 86400 * 2
        
        todayformatter.dateFormat = "dd"
        let stringToday6 = todayformatter.string(from: today6)
        return stringToday6
    }
    
    
    static func todayDateInfo7() -> String {
        let todaydate = Date()
        let todayformatter = DateFormatter()
        let today7 = todaydate + 86400 * 3
        
        todayformatter.dateFormat = "dd"
        let stringToday7 = todayformatter.string(from: today7)
        return stringToday7
    }
    
//////////////////////////////////////끝/////////////////////////////////////////
    
    
}

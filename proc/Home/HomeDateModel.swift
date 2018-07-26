import UIKit
import Foundation



class HomeDateModel : UIViewController {
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

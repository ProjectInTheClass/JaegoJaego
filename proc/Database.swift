// 로컬 저장소
import Foundation
import UIKit

/** 아카이브용 Database */
//let DataBase = Database()
//
//class Database {
//
//}


/* 홈 데이터 - HomeDateModel */

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

// 폐기 데이터 배열 생성
class HomedisposalChart_Model {
    var selectedIndex:Int = 0
    var HomeThrowArray:[HomeThrowChart]
    
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




/* 일정 데이터 - ScheduleDataModel */

// 일정 데이터 저장소
let ScheduleDatabase = ScheduleModel()

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

struct Event { //이벤트
    var eventname: String? //제목
    var text: String? //내용
    var eventdate: Int? //날짜
    
    
    // 이벤트 생성자
    init(eventname:String, text:String ){
        self.eventname = eventname
        self.text = text
    }
}

// 일정 배열 <일정 데이터>
class ScheduleModel {
    var ScheduleArray: [Schedule] = []
    
    init(){
        // 예약 시간에 따른 정렬 (1시  2시  5시 순)
        // 순서에 따른 count 값
        
        let stock1 =  Schedule(title: "예약", memo:"태권도팀 30명", dates: "20180730")
        let stock2 =  Schedule(title: "예약", memo:"삼성전자 단체회식 40명", dates: "20180816")
        let stock3 =  Schedule(title: "메모", memo:"일반 8인", dates: "20180815")
        let stock4 =  Schedule(title: "어린이", memo:"12명", dates: "20180813")
        self.ScheduleArray += [stock1, stock2, stock3, stock4]
        
    }
    
}




/* 재고 데이터 - StoreDataModel */
// store 모델 저장소
var StoreDatabase = StoreModel()
let fileName = "StoreBranchData.brch"

// 보관 방법
enum saveStyle : String {
    case Fresh = "실온"
    case Cold = "냉장"
    case Ice = "냉동"
}

// 재료 하나 정보
class Store// : NSObject, NSCoding
{
    // 인스턴스 소문자로 변환
    
    var name: String // 제품 이름
    var UpDate:String? // 등록 날
    var DownDate: String // 유통기한
    var many: Int = 0// 수량
    var manytype :String // 단위 = degree..
    var saveStyle: saveStyle // 보관 상태
    
    var Image: String? // 그래프 이미지
    var TotalMany:Int = 0 // 전체 수량
    var Call:String? // 거래처
    var userAmount:Int? // 유저가 등록하는 알람수량
    
    
    // 재고 상세 데이터 생성자
    init(name:String, UpDate:String, DownDate:String, many:Int, manytype:String, saveStyle:saveStyle,  TotalMany:Int, Call:String?, userAmount:Int){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        self.many = many
        self.manytype = manytype
        self.saveStyle = saveStyle
        
        self.TotalMany = TotalMany + many
        self.Call = Call
        self.userAmount = userAmount
        // 거래처와 이미지는 안받아도 됨, 전체 수량은 수량으로 계산
    }
    
    // 아카이브 코드
//
//    required convenience init?(coder aDecoder: NSCoder) {
//        name = aDecoder.decodeObject(forKey: "name") as! String
//        UpDate = aDecoder.decodeObject(forKey: "update") as! String
//        DownDate = aDecoder.decodeObject(forKey: "DownDate") as! String
//        many = Int(aDecoder.decodeInt64(forKey: "many"))
//        manytype = aDecoder.decodeObject(forKey: "manytype") as! String
//        saveStyle = aDecoder.decodeObject(forKey: "saveStyle") as! saveStyle
//
//        Image = aDecoder.decodeObject(forKey: "Image") as! String
//        TotalMany = TotalMany + many
//        Call = aDecoder.decodeObject(forKey: "Call") as! String
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.name, forKey: "name")
//        aCoder.encode(self.UpDate, forKey: "UpDate")
//        aCoder.encode(self.DownDate, forKey: "DownDate")
//        aCoder.encode(self.many, forKey: "many")
//        aCoder.encode(self.saveStyle, forKey: "saveStyle")
//
//        aCoder.encode(self.Image, forKey: "Image")
//        aCoder.encode(self.TotalMany, forKey:"TotalMany")
//        aCoder.encode(self.Call, forKey: "Call")
//    }
//
}


// 재고 ArrayList

class StoreModel //: Equatable
{
//    static func == (lhs: StoreModel, rhs: StoreModel) -> Bool {
//        lhs.key == rhs.key
//    }
    
    let key =  Date().timeIntervalSince1970
    var selectedIndex:Int = 0
    var arrayList:[Store] = []
    
    var filePath:String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true).first!
        return documentDirectory + fileName
        }}
    
    
    // 들어온 날짜 = 당일 날짜
    var infoDate2:String = HomeDateModel.dateInfo()
    
    
    init(){
        // if NSFileManager.defaultManager().fileExistsAtPath(self.filePath)
//        if FileManager.default.fileExists(atPath: self.filePath){
//            // read
//            var unarchArray: <# Type #> = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Store] {
//                arrayList += unarchArray
//            }
//        } else{
//            //create
//            arrayList += defaultData()
//        }
        
        self.arrayList = []
        
        
                var stock = Store(name:"새우", UpDate: infoDate2, DownDate:"2018년 07월 22일", many: 20, manytype:"통", saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222", userAmount: 30 )
                stock.Image = "그래프"
                self.arrayList.append(stock)
                stock = Store(name:"레몬",  UpDate: infoDate2, DownDate:"2018년 07월 21일", many: 5, manytype: "개",saveStyle: .Cold, TotalMany:20, Call:"010-4444-4444", userAmount: 30)
                stock.Image = "그래프"
                self.arrayList.append(stock)
                stock = Store(name:"아보카도",  UpDate: infoDate2, DownDate:"2018년 07월 22일",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332", userAmount: 30)
                stock.Image = "그래프"
                self.arrayList.append(stock)
        
    }
//    func save() {
//        NSKeyedArchiver.archiveRootObject(self.arrayList, toFile: self.filePath)
//    }
//
//    func defaultData() -> Array<Store>{
//        var stock = Store(name:"새우", UpDate: infoDate2, DownDate:"2018년 07월 22일", many: 20, manytype:"통", saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222", userAmount: 30 )
//        stock.Image = "그래프"
//        self.arrayList.append(stock)
//        stock = Store(name:"레몬",  UpDate: infoDate2, DownDate:"2018년 07월 21일", many: 5, manytype: "개",saveStyle: .Cold, TotalMany:20, Call:"010-4444-4444", userAmount: 30)
//        stock.Image = "그래프"
//        self.arrayList.append(stock)
//        stock = Store(name:"아보카도",  UpDate: infoDate2, DownDate:"2018년 07월 22일",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332", userAmount: 30)
//        stock.Image = "그래프"
//        self.arrayList.append(stock)
//    }
}

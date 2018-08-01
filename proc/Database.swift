// 로컬 저장소
import Foundation
import UIKit

/** 아카이브용 Database */
//let DataBase = Database()
//
//class Database {
//
//


/* 색상 지정 클래스 */

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
        
        dateFormatter.dateFormat = "yy.MM.dd"
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
struct Schedule :Equatable {
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
    
    init(){
        // 예약 시간에 따른 정렬 (1시  2시  5시 순)
        // 순서에 따른 count 값
        let stock1 =  Schedule(memotitle: "예약 2팀",memotime: "2 pm", memodates:"20180801")
        let stock2 =  Schedule(memotitle: "예약 4팀",memotime: "5 pm", memodates:"20180803")
        let stock3 =  Schedule(memotitle: "예약 5팀",memotime: "9 am", memodates:"20180804")
        let stock4 =  Schedule(memotitle: "예약 7팀",memotime: "11 am", memodates:"20180805")
        self.ScheduleArray += [stock1, stock2, stock3, stock4, stock1, stock2]
        
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
class Store :Equatable //: NSObject, NSCoding
{
    // 인스턴스 소문자로 변환
    
    var name: String // 제품 이름
    var UpDate: String  // 등록 날 -
    var DownDate: String // 유통기한
    var untilDate: Int // 남은 기간 일자 (day)
    
    var many: Int = 0// 수량
    var manytype :String // 단위 = degree..
    var saveStyle: saveStyle // 보관 상태
    
    var Image: String? // 그래프 이미지
    var TotalMany:Int = 0 // 전체 수량
    var Call:String? // 거래처
    //var userAmount:Int? // 유저가 등록하는 알람수량
    
    let key =  Date().timeIntervalSince1970
    
    static func == (lhs: Store, rhs: Store) -> Bool {
        return lhs.key == rhs.key
    }

    // 남은 기간 계산하기
    func dateFormater(downdate:String) -> Int {
        
       let dateformatter = DateFormatter()
        // = update
        dateformatter.dateFormat = "yy-MM-dd"
        
        let datenow = Date() // 오늘의 날짜
        // Date -> 문자열
        let datenowstring = dateformatter.string(from: datenow) // datanowstring = string
        
        // 문자열 -> Date
        let dateTemp:Date = dateformatter.date(from: datenowstring)! // datetemp = Date?
        let dateDate:Date = dateformatter.date(from: downdate)! //dateDate = Date?
        // 유통기간 - 오늘날
        let dateformat = dateDate.timeIntervalSince1970 - dateTemp.timeIntervalSince1970
        let between = Date.init(timeIntervalSince1970: dateformat) // dateformat = Date
        print(between)
        
        // Date -> 문자열
        
        let interval = dateformat
        
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.day]
//        formatter.unitsStyle = .positional
        
        let days = Int(interval / 24 / 60 / 60)
        
//        let formattedString = formatter.string(from: TimeInterval(interval))!
//        print(formattedString)
//
//        dateformatter.dateFormat = "dd"
//        let dateStr = dateformatter.string(from: between) //dateStr = string

        
        
        return days
//        intervalformatter.dateStyle = .full
//        intervalformatter.timeStyle = .full

        //let string = intervalformatter.stringFromDate(fromDate as Date, toDate: DownDate)
    }
    
    func updateUntilDate(){
        self.untilDate = dateFormater(downdate: DownDate)
    }
   
    // 재고 상세 데이터 생성자
    init(name:String, UpDate:String, DownDate:String, many:Int, manytype:String, saveStyle:saveStyle,  TotalMany:Int, Call:String?){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        
        self.many = many
        self.manytype = manytype
        self.saveStyle = saveStyle
        
        self.TotalMany = TotalMany + many
        self.Call = Call

        
        
//        var name: String // 제품 이름
//        var UpDate: String  // 등록 날 -
//        var DownDate: String // 유통기한
//        var untilDate: Int // 남은 기간 일자 (day)
//
//        var many: Int = 0// 수량
//        var manytype :String // 단위 = degree..
//        var saveStyle: saveStyle // 보관 상태
//
//        var Image: String? // 그래프 이미지
//        var TotalMany:Int = 0 // 전체 수량
//        var Call:String? // 거래처
        
        untilDate = 0
        untilDate = self.dateFormater(downdate: DownDate)
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

class StoreModel
{

    var sectionNum: Int = 0
    var selectedIndex:Int = 0

    var arrayList:[Store] = []
    
    var filePath:String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true).first!
        return documentDirectory + fileName
        }}
    
    
    // 들어온 날짜 = 당일 날짜
    
    
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
        
        var stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.06", many: 20, manytype:"통", saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222")
        stock.Image = "그래프(빨)"
        self.arrayList.append(stock)
        
        stock = Store(name:"레몬",  UpDate:"18.7.31", DownDate:"18.08.3", many: 5, manytype: "개",saveStyle: .Cold, TotalMany:20, Call:"010-4444-4444")
        stock.Image = "그래프(주황)"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate:"18.7.30", DownDate:"18.08.4",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332" )
        stock.Image = "그래프(초록)"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate:"18.7.30", DownDate:"18.9.4",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332" )
        stock.Image = "그래프(초록)"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate:"18.7.30", DownDate:"18.10.4",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332" )
        stock.Image = "그래프(초록)"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate:"18.7.20", DownDate:"18.7.30",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332" )
        stock.Image = "그래프(초록)"
        self.arrayList.append(stock)
    }
    /**
     저장된 목록에서 유통기한 남은 일자를 기준으로 목록을 새로 뽑아준다.
     */
    func storesUntilDate(fromDays:Int, toDays:Int?) -> [Store]{
        var arrayReturn = [Store]()
        
        for s in arrayList {
            s.updateUntilDate()
            
            // 유통기한 세이프
            if s.untilDate >= fromDays {  //  && s.untilDate < toDays { // 남은 잘짜가 맞으면.
               
                if let toD = toDays {
                    //유통기간 7일 이하인 것
                    if s.untilDate < toD {
                        arrayReturn.append(s)
                    }
                }
                // 유통기한 7일 이상인 것
                else {
                    arrayReturn.append(s)
                }
            }
            // 폐기 물품
            else {
                
            }
         
        }
        return arrayReturn
    }
    
    
    
//    func save() {
//        NSKeyedArchiver.archiveRootObject(self.arrayList, toFile: self.filePath)
//    }
//
}

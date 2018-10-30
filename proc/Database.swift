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
}



/* 일정 데이터 - ScheduleDataModel */

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
        let stock1 =  Schedule(memotitle: "예약 2팀",memotime: "02:40 pm", memodates:"20181027")
        let stock2 =  Schedule(memotitle: "예약 4팀",memotime: "05:30 pm", memodates:"20181027")
        let stock3 =  Schedule(memotitle: "예약 5팀",memotime: "09:20 am", memodates:"20181028")
        let stock4 =  Schedule(memotitle: "예약 7팀",memotime: "11:00 am", memodates:"20181029")
        let stock5 =  Schedule(memotitle: "예약 4팀",memotime: "05:00 pm", memodates:"20181030")
        let stock6 =  Schedule(memotitle: "예약 5팀",memotime: "09:30 am", memodates:"20181026")
        let stock7 =  Schedule(memotitle: "예약 2팀",memotime: "02:20 pm", memodates:"20181024")
        self.ScheduleArray += [stock1, stock2, stock3, stock4, stock5, stock6,stock7]
        self.dateArray += [stock1.memodates,stock2.memodates,stock3.memodates,stock4.memodates,stock5.memodates,stock6.memodates,stock7.memodates]
    }
    
}




/* 재고 데이터 - StoreDataModel */
// store 모델 저장소
var StoreDatabase = StoreModel()
//let fileName = "StoreBranchData.brch"

// 보관 방법
enum saveStyle : String {
    case Fresh = "room"
    case Cold = "cold"
    case Ice = "frozen"
}

// 재료 하나 정보
class Store : Equatable
{
    
    // 인스턴스 소문자로 변환
    
    var name: String // 제품 이름
    var UpDate: String  // 등록 날 -
    var DownDate: String // 유통기한
    var untilDate: Int // 남은 기간 일자 (day)
    
    var many: Int = 0// 수량
    var manytype :String // 단위 = degree..
    var saveStyle: saveStyle // 보관 상태
    var saveImage: String? //보관상태 이미지
    
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
        let days = Int(interval / 24 / 60 / 60)
        
        return days
    }
    
    /** 그래프 이미지 변경기
     */
    func storesManyFilteredTotalMany() {
        
        let temp:Double = Double(self.many) / Double(self.TotalMany)
        
        // 전체수량은 수량보다 작으면 안됨
        if self.TotalMany - self.many >= 0 {
            
            if temp > 0 && temp <= 0.25 {
                self.Image = "wG4-1"
            }
            else if temp > 0.25 && temp <= 0.5 {
                self.Image = "wG2"
            }
            else if temp > 0.5 && temp <= 0.75 {
                self.Image = "wG3"
            }
            else if temp > 0.75 && temp <= 1 {
                self.Image = "wG1"
            }
        }
        else {
            self.Image = "graph_0"
        }
        
    }
    
    func updateUntilDate(){
        self.untilDate = dateFormater(downdate: DownDate)
    }
    
    // 재고 상세 데이터 생성자
    init(name:String, UpDate:String, DownDate:String, many:Int, manytype:String, saveStyle:saveStyle,  Call:String?){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        
        self.many = many
        self.manytype = manytype
        self.saveStyle = saveStyle
        self.saveImage = saveStyle.rawValue
        
        self.Call = Call
        
        TotalMany += many
        untilDate = 0
        untilDate = self.dateFormater(downdate: DownDate)
        storesManyFilteredTotalMany()
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
    var arraynumList:[Int] = [] //수량 0이 될때 셀 삭제할때 쓰는 배열
    
//    var filePath:String { get {
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true).first!
//        return documentDirectory + fileName
//        }}
    
    
    // 들어온 날짜 = 당일 날짜
    
    
    init(){
        arrayList = []
        var stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.06", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"레몬",  UpDate:"18.7.31", DownDate:"18.08.03", many: 5, manytype: "개",saveStyle: .Cold,  Call:"010-4444-4444")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"아보카도",  UpDate:"18.7.30", DownDate:"18.08.04",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"젤리",  UpDate:"18.7.30", DownDate:"18.11.5",many: 15, manytype:"개", saveStyle: .Fresh, Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"망고",  UpDate:"18.7.30", DownDate:"18.10.7",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"아보카도",  UpDate:"18.7.20", DownDate:"18.7.30",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.04", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.05", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.05", many: 5, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        
    }
    
    
    /**
     전체수량 계산기
     */
    func sameStoreMany() {
        var dicTotal = [String:Int]()
        
        // 1. 각 제품별 총 합계를 구해서 딕에 담기.
        for store in self.arrayList {
            var total = store.many
            
            if let totalCount = dicTotal[store.name] {
                total = totalCount + store.many
            }
            dicTotal[store.name] = total
        }
        // 2. 각 스토어 전체 합계를 업데이트.
        for store in self.arrayList {
            store.TotalMany = dicTotal[store.name]!
            store.storesManyFilteredTotalMany()
        }
        
    }
    
    /**
     수량 / 전체수량 = 0.75/1 ~ 1/1 인 목록 추출기
     */
    func showLessManyItem() -> [Store] {
        var arrayLessItem = [Store]()
        var temp :Double
        
        sameStoreMany()
        
        for item in self.arrayList {
            temp = Double(item.many) / Double(item.TotalMany)
            
            if temp >= 0.75 && temp <= 1 {
                arrayLessItem.append(item)
            }
        }
        return arrayLessItem
    }
    
    
    /**
     저장된 목록에서 유통기한 남은 일자를 기준으로 목록을 새로 뽑아준다.
     */
    func storesUntilDate(fromDays:Int, toDays:Int?) -> [Store]{
        var arrayReturn = [Store]()
        
        for s in arrayList {
            s.updateUntilDate()
            
            // 폐기 물품
            if fromDays < 0 {
                if s.untilDate < 0{
                    arrayReturn.append(s)
                    
                }
                continue
            }
            
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
            
        }
        return arrayReturn
    }
}


//// 로컬 저장소
//import Foundation
//import UIKit
//
///** 아카이브용 Database */
////let DataBase = Database()
////
////class Database {
////
////
//
//
///* 색상 지정 클래스 */
//
//extension UIColor {
//    convenience init(red: Int, green: Int, blue: Int) {
//        let newRed = CGFloat(red)/255
//        let newGreen = CGFloat(green)/255
//        let newBlue = CGFloat(blue)/255
//
//        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
//    }
//}
//
//struct Colors {
//    static var darkGreen = UIColor(red: 46, green: 204, blue: 113)
//    static var darkBlue = UIColor(red: 52, green: 152, blue: 219)
//}
//
//
//class HomeDateModel {
//    /** 오늘 날짜 출력하는 클래스
//     */
//
//    //오늘 날짜 구하는 함수. 년, 월, 일
//    static func dateInfo()-> String {
//        let date = Date()
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "yy.MM.dd"
//        let stringDate = dateFormatter.string(from: date)
//        return stringDate
//
//    }
//
//    let infoDate = HomeDateModel.dateInfo()
//}
//
//
//
///* 일정 데이터 - ScheduleDataModel */
//
//// 일정 데이터 저장소
//let ScheduleDatabase = ScheduleModel()
//
//// 일정 데이터 정의
//class Schedule :Equatable {
//    var memotitle: String // 메모
//    var memotime: String // 시간
//    var memodates: String // 달력과 비교할 날짜
//
//    //  var counts:Int 는 셀의 개수로 넣음
//    let key =  Date().timeIntervalSince1970
//
//    static func == (lhs: Schedule  , rhs: Schedule) -> Bool {
//        return lhs.key == rhs.key
//    }
//
//    init(memotitle:String, memotime:String, memodates:String) {
//        self.memotitle = memotitle
//        self.memotime = memotime
//        self.memodates = memodates
//    }
//}
//
//// 일정 배열 <일정 데이터>
//class ScheduleModel {
//    var ScheduleArray: [Schedule] = []
//    var dateArray = [String]()
//    init(){
//        // 예약 시간에 따른 정렬 (1시  2시  5시 순)
//        // 순서에 따른 count 값
//        let stock1 =  Schedule(memotitle: "예약 2팀",memotime: "02:40 pm", memodates:"20180801")
//        let stock2 =  Schedule(memotitle: "예약 4팀",memotime: "05:30 pm", memodates:"20180803")
//        let stock3 =  Schedule(memotitle: "예약 5팀",memotime: "09:20 am", memodates:"20180824")
//        let stock4 =  Schedule(memotitle: "예약 7팀",memotime: "11:00 am", memodates:"20180809")
//        let stock5 =  Schedule(memotitle: "예약 4팀",memotime: "05:00 pm", memodates:"20180822")
//        let stock6 =  Schedule(memotitle: "예약 5팀",memotime: "09:30 am", memodates:"20180814")
//        let stock7 =  Schedule(memotitle: "예약 2팀",memotime: "02:20 pm", memodates:"20180802")
//        self.ScheduleArray += [stock1, stock2, stock3, stock4, stock5, stock6,stock7]
//        self.dateArray += [stock1.memodates,stock2.memodates,stock3.memodates,stock4.memodates,stock5.memodates,stock6.memodates,stock7.memodates]
//    }
//
//}
//
//
//
//
///* 재고 데이터 - StoreDataModel */
//// store 모델 저장소
//var StoreDatabase = StoreModel(coder: <#NSCoder#>)
//let fileName = "StoreBranchData.brch"
//
//// 보관 방법
//enum saveStyle : String {
//    case Fresh = "room"
//    case Cold = "cold"
//    case Ice = "frozen"
//}
//
//// 재료 하나 정보
//class Store : NSObject,NSCoding //, Equatable
//{
//
//    // 인스턴스 소문자로 변환
//
//    var name: String // 제품 이름
//    var UpDate: String  // 등록 날 -
//    var DownDate: String // 유통기한
//    var untilDate: Int // 남은 기간 일자 (day)
//
//    var many: Int = 0// 수량
//    var manytype :String // 단위 = degree..
//    var saveStyle: saveStyle // 보관 상태
//    var saveImage: String? //보관상태 이미지
//
//    var Image: String? // 그래프 이미지
//    var TotalMany:Int = 0 // 전체 수량
//    var Call:String? // 거래처
//    //var userAmount:Int? // 유저가 등록하는 알람수량
//
//    let key =  Date().timeIntervalSince1970
//
//    static func == (lhs: Store, rhs: Store) -> Bool {
//        return lhs.key == rhs.key
//    }
//
//
//
//    // 남은 기간 계산하기
//    func dateFormater(downdate:String) -> Int {
//
//       let dateformatter = DateFormatter()
//        // = update
//        dateformatter.dateFormat = "yy-MM-dd"
//
//        let datenow = Date() // 오늘의 날짜
//        // Date -> 문자열
//        let datenowstring = dateformatter.string(from: datenow) // datanowstring = string
//
//        // 문자열 -> Date
//        let dateTemp:Date = dateformatter.date(from: datenowstring)! // datetemp = Date?
//        let dateDate:Date = dateformatter.date(from: downdate)! //dateDate = Date?
//        // 유통기간 - 오늘날
//        let dateformat = dateDate.timeIntervalSince1970 - dateTemp.timeIntervalSince1970
//        let between = Date.init(timeIntervalSince1970: dateformat) // dateformat = Date
//        print(between)
//
//        // Date -> 문자열
//
//        let interval = dateformat
//        let days = Int(interval / 24 / 60 / 60)
//
//        return days
//    }
//
//    /** 그래프 이미지 변경기
//     */
//    func storesManyFilteredTotalMany() {
//
//        let temp:Double = Double(self.many) / Double(self.TotalMany)
//
//        // 전체수량은 수량보다 작으면 안됨
//        if self.TotalMany - self.many >= 0 {
//
//            if temp > 0 && temp <= 0.25 {
//                self.Image = "wG1"
//            }
//            else if temp > 0.25 && temp <= 0.5 {
//                self.Image = "wG2"
//            }
//            else if temp > 0.5 && temp <= 0.75 {
//                self.Image = "wG3"
//            }
//            else if temp > 0.75 && temp <= 1 {
//                self.Image = "wG4-1"
//            }
//        }
//        else {
//            self.Image = "graph_0"
//        }
//
//    }
//
//    func updateUntilDate(){
//        self.untilDate = dateFormater(downdate: DownDate)
//    }
//
//    // 재고 상세 데이터 생성자
//    init(name:String, UpDate:String, DownDate:String, many:Int, manytype:String, saveStyle:saveStyle,  Call:String?){
//        self.name = name
//        self.UpDate = UpDate
//        self.DownDate = DownDate
//
//        self.many = many
//        self.manytype = manytype
//        self.saveStyle = saveStyle
//        self.saveImage = saveStyle.rawValue
//
//        self.Call = Call
//
//        TotalMany += many
//        untilDate = 0
//        untilDate = self.dateFormater(downdate: DownDate)
//        storesManyFilteredTotalMany()
//    }
//
//    // 아카이브 코드
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
//}
//
//
//// 재고 ArrayList
//
//class StoreModel :NSObject, NSCoding
//{
//    func encode(with aCoder: NSCoder) {
//        <#code#>
//    }
//
//
//
//    var sectionNum: Int = 0
//    var selectedIndex:Int = 0
//
//    var arrayList:[Store] = []
//    var arraynumList:[Int] = [] //수량 0이 될때 셀 삭제할때 쓰는 배열
//
//    var filePath:String { get {
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true).first!
//        return documentDirectory + fileName
//        }}
//
//
//    // 들어온 날짜 = 당일 날짜
//
//    required init?(coder aDecoder: NSCoder) {
//        arrayList = []
//        var stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.06", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"레몬",  UpDate:"18.7.31", DownDate:"18.08.03", many: 5, manytype: "개",saveStyle: .Cold,  Call:"010-4444-4444")
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"아보카도",  UpDate:"18.7.30", DownDate:"18.08.04",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
//
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"젤리",  UpDate:"18.7.30", DownDate:"18.11.5",many: 15, manytype:"개", saveStyle: .Fresh, Call:"010-3333-2332" )
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"망고",  UpDate:"18.7.30", DownDate:"18.10.7",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"아보카도",  UpDate:"18.7.20", DownDate:"18.7.30",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.04", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.05", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//        stock = Store(name:"새우", UpDate:"18.8.01", DownDate:"18.08.05", many: 5, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
//        self.arrayList.append(stock)
//        self.arraynumList.append(stock.many)
//
//    }
//
//    /**
//     전체수량 계산기
//     */
//    func sameStoreMany() {
//        var dicTotal = [String:Int]()
//
//        // 1. 각 제품별 총 합계를 구해서 딕에 담기.
//        for store in self.arrayList {
//            var total = store.many
//
//            if let totalCount = dicTotal[store.name] {
//                total = totalCount + store.many
//            }
//            dicTotal[store.name] = total
//        }
//        // 2. 각 스토어 전체 합계를 업데이트.
//        for store in self.arrayList {
//            store.TotalMany = dicTotal[store.name]!
//            store.storesManyFilteredTotalMany()
//        }
//
//    }
//
//    /**
//     수량 / 전체수량 = 0.75/1 ~ 1/1 인 목록 추출기
//     */
//    func showLessManyItem() -> [Store] {
//        var arrayLessItem = [Store]()
//        var temp :Double
//
//        sameStoreMany()
//
//        for item in self.arrayList {
//            temp = Double(item.many) / Double(item.TotalMany)
//
//            if temp >= 0.75 && temp <= 1 {
//                arrayLessItem.append(item)
//            }
//        }
//        return arrayLessItem
//    }
//
//
//    /**
//     저장된 목록에서 유통기한 남은 일자를 기준으로 목록을 새로 뽑아준다.
//     */
//    func storesUntilDate(fromDays:Int, toDays:Int?) -> [Store]{
//        var arrayReturn = [Store]()
//
//        for s in arrayList {
//            s.updateUntilDate()
//
//            // 폐기 물품
//            if fromDays < 0 {
//                if s.untilDate < 0{
//                    arrayReturn.append(s)
//
//                }
//              continue
//            }
//
//            // 유통기한 세이프
//            if s.untilDate >= fromDays {  //  && s.untilDate < toDays { // 남은 잘짜가 맞으면.
//                if let toD = toDays {
//                    //유통기간 7일 이하인 것
//                    if s.untilDate < toD {
//                        arrayReturn.append(s)
//                    }
//                }
//                // 유통기한 7일 이상인 것
//                else {
//                    arrayReturn.append(s)
//                }
//            }
//
//        }
//        return arrayReturn
//    }
//
//
//
//
//
////    func save() {
////        NSKeyedArchiver.archiveRootObject(self.arrayList, toFile: self.filePath)
////    }
////
//}

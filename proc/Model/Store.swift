//
//  Store.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import Foundation

let StoreDatabase : StoreModel = StoreModel()
let fileName = "Jaegojaego.file"

// 보관 방법
enum saveStyle : String {
    case Fresh = "room" //실온
    case Cold = "cold" // 냉장
    case Ice = "frozen" // 냉동
}

// 재료 하나 정보
class Store : NSObject, NSCoding
{
    // 입력받는 값
    var name: String // 제품 이름
    var UpDate: Date  // 등록 날
    var DownDate: Date // 유통기한
    
    var many: Int = 0// 수량
    var manytype :String // 단위 = degree..
    var saveStyle: saveStyle // 보관 상태
    
    // 자동처리 값
    var untilDate: Int { return dateFormater(downdate: DownDate) }// 남은 기간 일자 (day)
    var saveImage: String? //보관상태 이미지
    var Image: String? // 그래프 이미지
    var TotalMany:Int = 0 // 전체 수량
    
    let key =  Date().timeIntervalSince1970
//    static func == (lhs: Store, rhs: Store) -> Bool {
//        return lhs.key == rhs.key
//    }
    override func isEqual(_ object: Any?) -> Bool {
        return key == (object as? Store)?.key
    }
    
    init(name:String, UpDate:Date, DownDate:Date, many:Int, manytype:String, saveStyle:saveStyle){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        
        self.many = many
        self.manytype = manytype
        self.saveStyle = saveStyle
        
        TotalMany += many
        
        super.init() //안쓰면 함수 못쓰는데 필요한 이유를 모르겠음
        storesManyFilteredTotalMany()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.UpDate = aDecoder.decodeObject(forKey: "UpDate") as! Date
        self.DownDate = aDecoder.decodeObject(forKey: "DownDate") as! Date
        
        self.many = aDecoder.decodeInteger(forKey: "many")
        self.manytype = aDecoder.decodeObject(forKey: "manytype") as! String
        self.saveStyle = aDecoder.decodeObject(forKey: "saveStyle") as! saveStyle
        self.TotalMany += many
        super.init()
        storesManyFilteredTotalMany()
    }
   
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.UpDate, forKey: "UpDate")
        aCoder.encode(self.DownDate, forKey: "DownDate")
        
        aCoder.encode(self.many, forKey: "many")
        aCoder.encode(self.manytype, forKey: "manytype")
        aCoder.encode(self.saveStyle, forKey: "saveStyle")
        aCoder.encode(self.saveImage, forKey: "saveImage")
    }
    
    
    
    
    // 남은 기간 계산하기
    func dateFormater(downdate:Date) -> Int {
        // 유통기간 - 오늘날
        let today = Date()
        let dateformat = downdate.timeIntervalSince1970 - today.timeIntervalSince1970
        
        // Date -> 문자열
        let days = Int(dateformat / 24 / 60 / 60)
        
        return days
    }
    
    /** 그래프 이미지 변경 */
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
}

// 재고 ArrayList
class StoreModel
{
    
    
    var filePath : String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + fileName
        }
    }
    
    var sectionNum: Int = 0
    var selectedIndex:Int = 0
    
    var arrayList:[Store] = []
    var arraynumList:[Int] = [] //수량 0이 될때 셀 삭제할때 쓰는 배열
    var buyStockArray : [Store] {  // 입고 = (오늘 = 등록 날짜) , 내림차순
        return arrayList.filter{$0.UpDate  <= Date()}.sorted(by: {$0.UpDate > $1.UpDate})
    }
    
    var sellStockArray : [Store] {// 출고 = (오늘 = 마감 날짜) , 내림차순
        return arrayList.filter{$0.DownDate <= Date()}.sorted(by: {$0.DownDate > $1.DownDate})
    }
    
    init(){
        if FileManager.default.fileExists(atPath: self.filePath){ //read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Store] {
                arrayList += unarchArray
            }
        } else { //create
            print("creating new file with temporary datas...")
            arrayList += defaultData()
        }
    }
    
    func saveData() { // 터어어어ㅓ어짐
        NSKeyedArchiver.archiveRootObject(self.arrayList, toFile: self.filePath)
    }
    
    func defaultData() -> Array<Store> {
        let today = Date()
        let todayAfterWeek = Date() + (86400 * 7)
        let todayBeforeWeek = Date() - (86400 * 7)
        
        let stock1 = Store(name:"독도새우", UpDate:today, DownDate: today + (86400 * 4), many: 22, manytype:"통", saveStyle: .Cold)
        let stock2 = Store(name:"레몬",  UpDate:today - (86400 * 2), DownDate: todayAfterWeek, many: 6, manytype: "개",saveStyle: .Cold)
        let stock3 = Store(name:"아보카도",  UpDate:today - 86400, DownDate: todayAfterWeek,many: 11, manytype:"개", saveStyle: .Fresh )
        let stock4 = Store(name:"젤라또",  UpDate: today, DownDate: today + (86400 * 3),many: 9, manytype:"개", saveStyle: .Fresh)
        let stock5 = Store(name:"망고",  UpDate: todayBeforeWeek - 86400, DownDate: today ,many: 13, manytype:"개", saveStyle: .Fresh)
        let stock6 = Store(name:"까르보나라 소스",  UpDate: todayBeforeWeek, DownDate: todayAfterWeek,many: 4, manytype:"개", saveStyle: .Fresh)
        let stock7 = Store(name:"새우", UpDate: today - (86400 * 5), DownDate: today - 86400, many: 2, manytype:"통", saveStyle: .Cold)
        let stock8 = Store(name:"새우", UpDate:today - (86400 * 3), DownDate:today + (86400 * 3), many: 12, manytype:"통", saveStyle: .Cold)
        let stock9 = Store(name:"새우", UpDate: today - (86400 * 4), DownDate: todayAfterWeek + (86400 * 2), many: 7, manytype:"통", saveStyle: .Cold)
        
        return [stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9]
    }
    
    func getNewDatePerStock(date:Date) -> [Store]{
        return arrayList.filter{$0.UpDate == date }
    }
    
    func getOutDatePerStock(date:Date) -> [Store] {
        return arrayList.filter{$0.DownDate == date}
    }
    
    /** 전체수량 계산 */
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
    
    /** 수량 / 전체수량 = 0.75/1 ~ 1/1 인 목록 추출 */
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
    
    
    /** 저장된 목록에서 유통기한 남은 일자를 기준으로 목록을 새로 뽑아준다. */
    func storesUntilDate(fromDays:Int, toDays:Int?) -> [Store]{
        var arrayReturn = [Store]()
        
        for s in arrayList {
            //s.updateUntilDate()
            
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
    
    func stringToDate(value:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.date(from: value)!
    }
    
    func dateToString(value : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: value)
    }
    
    func returnTodayDate() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: today)
    }
}


//
//  Store.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//
import UIKit
import Foundation

let StoreDatabase : StoreModel = StoreModel()
let mainfileName = "JaegoList_Main.file"
let usedFileName = "JaegoList_Used.file"


class StoreModel
{
    // 재고 목록에 사용하는 배열
    var arrayList:[Store] = [] // 주 배열
    var outList : [Store] = [] // 출고 배열
    
    // 홈에 사용하는 배열
    var buyStockArray : [Store] {  // 입고 = (오늘 = 등록 날짜) , 내림차순
        return arrayList.filter{$0.UpDate  <= Date()}.sorted(by: {$0.UpDate > $1.UpDate})
    }
    
    var sellStockArray : [Store] {// 출고 = (오늘 = 마감 날짜) , 내림차순
        return outList.filter{$0.DownDate <= Date()}.sorted(by: {$0.DownDate > $1.DownDate})
    }
    
    // 재고 날짜 배열
    var stockUpDateArray : [Date] {
        return Array(Set(buyStockArray.compactMap{ $0.UpDate }))
    }
    var stockDownDateArray : [Date] {
        return Array(Set(sellStockArray.compactMap{ $0.DownDate }))
    }
    
    var stockListPerDate : [Date: [Store]]{
        var dateList = [Date:[Store]]()
        for i in stockUpDateArray {
            dateList.updateValue(buyStockArray.filter{$0.UpDate == i}, forKey: i)
        }
        return dateList
    }
    
    var outStockListPerDate : [Date : [Store]]{
        var dateList = [Date:[Store]]()
        for i in stockDownDateArray {
            dateList.updateValue(sellStockArray.filter{$0.DownDate == i}, forKey: i)
        }
        return dateList
    }
    
    // 아카이브
    var mainfilePath : String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + projectName + "/" + mainfileName
        }
    }
    var usedfilePath : String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + projectName + "/" + usedFileName
        }}
    
    func saveData() { 
        NSKeyedArchiver.archiveRootObject(self.arrayList, toFile: self.mainfilePath)
        NSKeyedArchiver.archiveRootObject(self.outList, toFile: self.usedfilePath)
    }
    
    // 테스트 데이터
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
        let stock9 = Store(name:"새우", UpDate: today - (86400 * 4), DownDate: todayAfterWeek + (86400 * 2), many: 7, manytype:"통", saveStyle: .Cold)

        return [stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock9]
        
    }
   
    // 입고 (date:Date) -> [Store]
    func getNewDatePerStock(date:Date) -> [Store]{
        return buyStockArray.filter{$0.UpDate == date }
    }
    // 출고 (date:Date) -> [Store]
    func getOutDatePerStock(date:Date) -> [Store] {
        return sellStockArray.filter{$0.UpDate == date}
    }
    
    
    /** 전체수량 계산 */
    func sameStoreMany() {
        var dicTotal = [String:Int]()
        arrayList.removeAll(where: {$0.many <= 0})
        
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
    
    init(){
        if FileManager.default.fileExists(atPath: self.mainfilePath){ //read
            if let mainarray = NSKeyedUnarchiver.unarchiveObject(withFile: self.mainfilePath) as? [Store] {
                arrayList = mainarray
            }
        } else { //create
            arrayList = defaultData()
        }
        
        if FileManager.default.fileExists(atPath: self.usedfilePath){
            if let usedarray = NSKeyedUnarchiver.unarchiveObject(withFile: self.usedfilePath) as? [Store] {
                outList = usedarray
            }
        }
    }
}



// 보관 방법
enum SaveStyle : String {
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
    var saveStyle: SaveStyle // 보관 상태
    
    // 자동처리 값
    var TotalMany:Int = 0 // 전체 수량
    var untilDate: Int { return dateFormater(downdate: DownDate) }// 남은 기간 일자 (day)
    var saveImage: String? //보관상태 이미지
    var Image: String { // 그래프 이미지
        let temp:Double = Double(self.many) / Double(self.TotalMany)
    
        // 전체수량은 수량보다 작으면 안됨
        if self.TotalMany - self.many >= 0 {
            if temp > 0 && temp <= 0.25 { return "wG4-1" }
            else if temp > 0.25 && temp <= 0.5 { return "wG2" }
            else if temp > 0.5 && temp <= 0.75 { return "wG3"}
            else { return "wG1" }
        } else { return "graph_0" }
    }
    
    let key =  Date().timeIntervalSince1970
    static func == (lhs: Store, rhs: Store) -> Bool {
        return lhs.key == rhs.key
    }
    
    init(name:String, UpDate:Date, DownDate:Date, many:Int, manytype:String, saveStyle:SaveStyle){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        
        self.many = many
        self.manytype = manytype
        self.saveStyle = saveStyle
        
        TotalMany += many
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.UpDate = aDecoder.decodeObject(forKey: "UpDate") as! Date
        self.DownDate = aDecoder.decodeObject(forKey: "DownDate") as! Date
        
        self.many = aDecoder.decodeInteger(forKey: "many")
        self.manytype = aDecoder.decodeObject(forKey: "manytype") as! String
        self.saveStyle = SaveStyle(rawValue: aDecoder.decodeObject(forKey: "saveStyle") as! String)! //aDecoder.decodeObject(forKey: "saveStyle") as! saveStyle
        self.TotalMany += many
    }
   
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.UpDate, forKey: "UpDate")
        aCoder.encode(self.DownDate, forKey: "DownDate")
        
        aCoder.encode(self.many, forKey: "many")
        aCoder.encode(self.manytype, forKey: "manytype")
        aCoder.encode(self.saveStyle.rawValue, forKey: "saveStyle")
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
    
}



//
//  Store.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import Foundation

var StoreDatabase = StoreModel()

// 보관 방법
enum saveStyle : String {
    case Fresh = "room"
    case Cold = "cold"
    case Ice = "frozen"
}

// 재료 하나 정보
class Store : Equatable
{
    var name: String // 제품 이름
    var UpDate: Date  // 등록 날
    var DownDate: Date // 유통기한
    var untilDate: Int // 남은 기간 일자 (day)
//    var writeDate: Date // 등록한 날짜 (Date)
    
    var many: Int = 0// 수량
    var manytype :String // 단위 = degree..
    var saveStyle: saveStyle // 보관 상태
    var saveImage: String? //보관상태 이미지
    
    var Image: String? // 그래프 이미지
    var TotalMany:Int = 0 // 전체 수량
    var Call:String? // 거래처
    
    let key =  Date().timeIntervalSince1970
    
    static func == (lhs: Store, rhs: Store) -> Bool {
        return lhs.key == rhs.key
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
    
    func updateUntilDate(){
        self.untilDate = dateFormater(downdate: DownDate)
    }
    
    init(name:String, UpDate:Date, DownDate:Date, many:Int, manytype:String, saveStyle:saveStyle,  Call:String?){
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
   
}


// 재고 ArrayList
class StoreModel
{
    var sectionNum: Int = 0
    var selectedIndex:Int = 0
    
    var arrayList:[Store] = []
    var arraynumList:[Int] = [] //수량 0이 될때 셀 삭제할때 쓰는 배열
    var buyStockArray : [Store] = [] // 입고 목록
    var sellStockArray : [Store] = [] // 출고 목록
    
    var newDatePerCountDic : [String : Int] = [:] // 날짜 당 입고 물품 개수를 저장하는 딕션어리
    var outDatePerCountDic : [String : Int] = [:] // 날짜 당 출고 물품 개수를 저장하는 딕션어리
    
    init(){
        arrayList = []
        
        let today = Date()
        let todayAfterWeek = Date() + (86400 * 7)
        let todayBeforeWeek = Date() - (86400 * 7)
        
        var stock = Store(name:"독도새우", UpDate:today, DownDate: today + (86400 * 4), many: 22, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"레몬",  UpDate:today - (86400 * 2), DownDate: todayAfterWeek, many: 6, manytype: "개",saveStyle: .Cold,  Call:"010-4444-4444")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"아보카도",  UpDate:today - 86400, DownDate: todayAfterWeek,many: 11, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"젤라또",  UpDate: today, DownDate: today + (86400 * 3),many: 9, manytype:"개", saveStyle: .Fresh, Call:"010-3333-2332")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"망고",  UpDate: todayBeforeWeek - 86400, DownDate: today ,many: 13, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"까르보나라 소스",  UpDate: todayBeforeWeek, DownDate: todayAfterWeek,many: 4, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate: today - (86400 * 5), DownDate: today - 86400, many: 2, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:today - (86400 * 3), DownDate:today + (86400 * 3), many: 12, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate: today - (86400 * 4), DownDate: todayAfterWeek + (86400 * 2), many: 7, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        // 입고 = (오늘 = 등록 날짜) , 내림차순
        buyStockArray = arrayList.filter{$0.UpDate  <= today}.sorted(by: {$0.UpDate > $1.UpDate})
        for i in buyStockArray {
            let getCount = newDatePerCountDic[dateToString(value: i.UpDate)] ?? 0
            newDatePerCountDic.updateValue(getCount + 1 , forKey: dateToString(value: i.UpDate))
        }
        
        // 출고 = (오늘 = 마감 날짜) , 내림차순
        sellStockArray = arrayList.filter{$0.DownDate <= today}.sorted(by: {$0.DownDate > $1.DownDate})
        for i in sellStockArray {
            let getCount = newDatePerCountDic[dateToString(value: i.DownDate)] ?? 0
            outDatePerCountDic.updateValue(getCount + 1, forKey: dateToString(value: i.DownDate))
        }
        

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

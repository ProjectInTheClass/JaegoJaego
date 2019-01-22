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
    var UpDate: String  // 등록 날 
    var DownDate: String // 유통기한
    var untilDate: Int // 남은 기간 일자 (day)
    
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
        
        // Date -> 문자열
        let interval = dateformat
        let days = Int(interval / 24 / 60 / 60)
        
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
    
    init(){
        arrayList = []
        
        var stock = Store(name:"새우", UpDate:"2018.8.01", DownDate:"2019.01.26", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"레몬",  UpDate:"2018.7.31", DownDate:"2019.01.23", many: 5, manytype: "개",saveStyle: .Cold,  Call:"010-4444-4444")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"아보카도",  UpDate:"2019.2.30", DownDate:"2019.03.03",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"젤리",  UpDate:"2019.1.22", DownDate:"2019.02.19",many: 15, manytype:"개", saveStyle: .Fresh, Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"망고",  UpDate:"2019.1.22", DownDate:"2019.02.20",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"까르보나라 소스",  UpDate:"2019.1.20", DownDate:"2019.03.30",many: 15, manytype:"개", saveStyle: .Fresh,  Call:"010-3333-2332" )
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:"2018.1.22", DownDate:"2019.01.20", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:"2018.1.31", DownDate:"2019.01.21", many: 20, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        stock = Store(name:"새우", UpDate:"2019.1.29", DownDate:"2019.03.01", many: 5, manytype:"통", saveStyle: .Cold, Call:"010-7730-7152")
        self.arrayList.append(stock)
        self.arraynumList.append(stock.many)
        
        arrayList.sorted(by: {$0.UpDate > $1.UpDate })
        
        // 입고 = (오늘 = 등록 날짜) , 내림차순
        buyStockArray = arrayList.filter{$0.UpDate <= returnTodayDate()}
        print("buyStockArray = \(buyStockArray)")
        // 출고 = (오늘 = 마감 날짜) , 내림차순
        sellStockArray = arrayList.filter{$0.DownDate <= returnTodayDate()}
        print("sellStockArray = \(sellStockArray)")
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
    
    func returnTodayDate() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: today)
    }
}

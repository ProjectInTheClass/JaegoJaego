//
//  StoreViewModel.swift
//  proc
//
//  Created by 성다연 on 2021/02/24.
//  Copyright © 2021 swuad-19. All rights reserved.
//

import Foundation

class StoreViewModel {
    private var StockArray : [Store] = []
    private var StockPerDateArray : [Date : [Store]] = [:]
    
    private let projectName = "JaegoJaego"
    private let mainFileName = "JaegoList_Main.file"
    
    private var mainFilePath : String { get {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + projectName + "/" + mainFileName
        }
    }
    
    init() {
        setArchiveFile()
    }
}


extension StoreViewModel {
    func returnBuyStockArray() -> [Store] { // 입고, 내림차순
        return StockArray.filter { $0.UpDate <= Date()}.sorted(by: { $0.UpDate > $1.UpDate})
    }
    
    func returnSellStockArray() -> [Store] {
        return StockArray.filter { $0.DownDate <= Date()}.sorted(by: { $0.DownDate > $1.DownDate})
    }
    
    func returnStockDateArray() -> [Date] {
        return Array(Set(StockArray.compactMap { $0.UpDate }))
    }
    
    func returnStockEqualDate(date: Date) -> [Store] {
        return StockArray.filter { $0.UpDate == date}
    }
    
    func addStock(data : Store) {
        StockArray.append(data)
    }
    
    func removeStock(data: Int){
        StockArray.remove(at: data)
    }
    
    func findStock(data : Int) -> Store {
        return StockArray[data]
    }
    
    func findStockIndex(data : Store) -> Int {
        return StockArray.index(of: data)!
    }
    
    /// 입고 목록
    func returnStockPerDateBuyArray() -> [Date: [Store]] {
        var list = [Date : [Store]]()
        let array = StockArray.filter { $0.UpDate <= Date()}
        let array2 = Array(Set(array.compactMap { $0.UpDate }))
        
        array2.forEach { date in
            list.updateValue(array.filter { $0.UpDate == date}, forKey: date)
        }
        return list
    }
    
    /// 출고 목록
    func returnStockPerDateOutArray() -> [Date: [Store]] {
        var list = [Date : [Store]]()
        let array = StockArray.filter { $0.many <= 0 }
        let array2 = Array(Set(array.compactMap { $0.DownDate }))
        
        array2.forEach { date in
            list.updateValue(array.filter { $0.DownDate == date}, forKey: date)
        }
        return list
    }
    
    /// 전체 수량 계산
    func returnStockTotalCount(){
        var dic : [String : Int] = [:]
        StockArray.removeAll(where: {$0.many <= 0})
        
        StockArray.forEach { store in
            var total = store.many
            if let totalCount = dic[store.name] {
                total = totalCount + store.many
            }
            dic[store.name] = total
        }
        
        StockArray.forEach { store in
            store.TotalMany = dic[store.name]!
        }
    }
    
    /// 재고가 부족한 목록 추출
    func returnStockLessItem() -> [Store] {
        var lessItem : [Store] = []
        var temp = Double(0.0)

        returnStockTotalCount()
        
        StockArray.forEach { stock in
            temp = Double(stock.many) / Double(stock.TotalMany)
            
            if temp >= 0.75 && temp <= 1 {
               lessItem.append(stock)
            }
        }
        return lessItem
    }
 
    func returnStockUntilDate(fromDays: Int, toDays: Int?) -> [Store] {
        var list : [Store] = []
      
        for stock in StockArray {
            /// 폐기 물품
            if fromDays < 0 {
                if stock.untilDate < 0 {
                    list.append(stock)
                }
                continue
            }
            
            /// 유통기한 얼마 남지 않은 것
            if stock.untilDate >= fromDays {
                if let day = toDays {
                    if stock.untilDate < day {
                        list.append(stock)
                    }
                } else {
                    list.append(stock)
                }
            }
        }
        return list.sorted(by: {$0.DownDate < $1.DownDate})
    }
    
    func setArchiveFile(){
        if FileManager.default.fileExists(atPath: mainFilePath){ //read
            if let mainarray = NSKeyedUnarchiver.unarchiveObject(withFile: mainFilePath) as? [Store] {
                StockArray = mainarray
            }
        } else { //create
            StockArray = defaultData()
        }
    }
    
    func defaultData() -> [Store] {
        let today = Date()
        let todayAfterWeek = Date() + (86400 * 7)
        let todayBeforeWeek = Date() - (86400 * 7)
        
        let list = [
            Store(name:"독도새우", UpDate:today, DownDate: today + (86400 * 4), many: 22, manytype:"통", saveStyle: .Cold),
            Store(name:"레몬",  UpDate:today - (86400 * 2), DownDate: todayAfterWeek, many: 6, manytype: "개",saveStyle: .Cold),
            Store(name:"아보카도",  UpDate: today - 86400, DownDate: todayAfterWeek,many: 11, manytype:"개", saveStyle: .Fresh),
            Store(name:"젤라또",  UpDate: today, DownDate: today + (86400 * 3),many: 9, manytype:"개", saveStyle: .Fresh),
            Store(name:"망고",  UpDate: todayBeforeWeek - 86400, DownDate: today ,many: 13, manytype:"개", saveStyle: .Fresh),
            Store(name:"까르보나라 소스",  UpDate: todayBeforeWeek, DownDate: todayAfterWeek,many: 4, manytype:"개", saveStyle: .Fresh),
            Store(name:"새우", UpDate: today - (86400 * 5), DownDate: today - 86400, many: 2, manytype:"통", saveStyle: .Cold),
            Store(name:"새우", UpDate: today - (86400 * 4), DownDate: todayAfterWeek + (86400 * 2), many: 7, manytype:"통", saveStyle: .Cold),
            
            Store(name:"랍스타", UpDate: today - (86400 * 4), DownDate: today, many: 0, manytype:"개", saveStyle: .Ice),
            Store(name:"오일", UpDate: today - (86400 * 9), DownDate: today - 86400, many: 0, manytype:"개", saveStyle: .Fresh)
        ]
        return list
    }
    
    func saveData() {
        NSKeyedArchiver.archiveRootObject(self.StockArray, toFile: self.mainFilePath)
    }
}

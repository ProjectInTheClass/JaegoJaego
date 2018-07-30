import UIKit
import Foundation


// store 모델 저장소
let StoreDatabase = StoreModel()

// 보관 방법
enum saveStyle : String {
    case Fresh = "실온"
    case Cold = "냉장"
    case Ice = "냉동"
}

// 재료 하나 정보
class Store //: NSObject, NSCoding
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
        // 거래처와 이미지는 안받아도 됨, 전체 수량은 수량으로 계산
    }
    
    // 아카이브 코드
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.name, forKey: "name")
//        aCoder.encode(self.UpDate, forKey: "UpDate")
//        aCoder.encode(self.DownDate, forKey: "DownDate")
//        aCoder.encode(self.many, forKey: "many")
//        aCoder.encode(self.saveStyle, forKey: "saveStyle")
//
//        aCoder.encode(self.Image, forKey: "Image")
//        aCoder.encode(self.TotalMany, forKey: "TotalMany")
//        aCoder.encode(self.Call, forKey: "Call")
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.name = aDecoder.decodeObject(forKey: "name") as! String
//        self.UpDate = aDecoder.decodeObject(forKey: "update") as! String
//        self.DownDate = aDecoder.decodeObject(forKey: "DownDate") as! String
//        self.many = Int(aDecoder.decodeInt64(forKey: "many"))
//        self.manytype = aDecoder.decodeObject(forKey: "manytype") as! String
//        //self.saveStyle = saveStyle(rawValue: aDecoder.decodeObject(forKey: "saveStyle") as! String)
//
//        self.Image = aDecoder.decodeObject(forKey: "Image") as! String
//        self.TotalMany = TotalMany + many
//        self.Call = aDecoder.decodeObject(forKey: "Call") as! String
//    }
}


// 재고 ArrayList
class StoreModel {
    var selectedIndex:Int = 0
    var arrayList:Array<Store>
    
    // 들어온 날짜 = 당일 날짜
    var infoDate2:String = HomeDateModel.dateInfo()
    
    init(){
        
        
        self.arrayList = []
        
        var stock = Store(name:"새우", UpDate: infoDate2, DownDate:"2018년 07월 22일", many: 20, manytype:"통", saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222" )
        stock.Image = "그래프"
        self.arrayList.append(stock)
        
        stock = Store(name:"레몬",  UpDate: infoDate2, DownDate:"2018년 07월 21일", many: 5, manytype: "개",saveStyle: .Cold, TotalMany:20, Call:"010-4444-4444")
        stock.Image = "그래프"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate: infoDate2, DownDate:"2018년 07월 22일",many: 15, manytype:"개", saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332")
        stock.Image = "그래프"
        self.arrayList.append(stock)
        
    }
}


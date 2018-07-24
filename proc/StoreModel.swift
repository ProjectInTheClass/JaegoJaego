import Foundation

enum saveStyle : String {
    case temp = "실온"
    case Cold = "냉장"
    case iceCold = "냉동"
}

class Store {
    let name: String
    let Date: String
    var many: String
    var Image: String?
    var save: saveStyle
    
    
    init(name:String, Date:String, many:String, saveStyle:saveStyle){
        self.name = name
        self.Date = Date
        self.many = many
        self.save = saveStyle
        //self.Image = Image
    }
}

class StoreModel {
    var selectedIndex:Int = 0
    var arrayList:Array<Store>
    
    init(){
//        let StoreChart:[Store] = [
//            Store(name:"새우", Date:"2018/07/22", many: "20", Image: "shrimp"),
//            Store(name:"레몬", Date:"2018/07/21", many: "5", Image: "lemon"),
//            Store(name:"아보카도", Date:"2018/07/22",many: "15", Image: "avocado"),
//            ]
        self.arrayList = []
        
        var stock = Store(name:"새우", Date:"2018/07/22", many: "20", saveStyle: .Cold)
        stock.Image = "shrimp"
        self.arrayList.append(stock)
        
        stock = Store(name:"레몬", Date:"2018/07/21", many: "5",saveStyle: .Cold)
        stock.Image = "lemon"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도", Date:"2018/07/22",many: "15", saveStyle: .temp)
        stock.Image = "avocado"
        self.arrayList.append(stock)
        
    }
}

import UIKit
import Foundation


enum saveStyle : String {
    case temp = "실온"
    case Cold = "냉장"
    case iceCold = "냉동"
}

struct Store {
    let name: String // 제품 이름
    var UpDate:String? // 등록 날
    let DownDate: String // 유통기한
    var many: Int = 0// 수량
    var saveStyle: saveStyle // 보관 상태
    
    var Image: String? // 그래프 이미지
    var TotalMany:Int = 0 // 전체 수량
    var Call:String? // 거래처
    
    
    // 재고 기본 데이터 생성자
    init(name:String, DownDate:String, many:Int, saveStyle:saveStyle){
        self.name = name
        self.DownDate = DownDate
        self.many = many
        self.saveStyle = saveStyle
        // 거래처와 이미지는 안받아도 됨, 전체 수량은 수량으로 계산
        //self.Image = Image
    }
    
    // 재고 상세 데이터 생성자
    init(name:String, UpDate:String, DownDate:String, many:Int, saveStyle:saveStyle, TotalMany:Int, Call:String?){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        self.many = many
        self.saveStyle = saveStyle
        
        //self.Image? = String(UIImage(named:Image))
        self.TotalMany = TotalMany + many
        self.Call = Call
        // 거래처와 이미지는 안받아도 됨, 전체 수량은 수량으로 계산
    }
}

// 재고 기본 데이터 표시
struct StoreModel {
    var selectedIndex:Int = 0
    var arrayList:Array<Store>
    
    init() {
        self.arrayList = []
        
        var stock = Store(name:"새우", DownDate:"2018/07/22", many: 20, saveStyle: .Cold)
        stock.Image = "shrimp"
        self.arrayList.append(stock)
        
        stock = Store(name:"레몬", DownDate:"2018/07/21", many: 5,saveStyle: .Cold)
        stock.Image = "lemon"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도", DownDate:"2018/07/22",many: 15, saveStyle: .temp)
        stock.Image = "avocado"
        self.arrayList.append(stock)
    }
    
}

// 재고 상세 데이터 표시
struct StoreModel_More {
    var selectedIndex:Int = 0
    var arrayList:Array<Store>
    
    // 들어온 날짜 = 당일 날짜
    var infoDate2:String = HomeViewCtroller.dateInfo()
    
    init(){
        //        let StoreChart:[Store] = [
        //            Store(name:"새우", Date:"2018/07/22", many: "20", Image: "shrimp"),
        //            Store(name:"레몬", Date:"2018/07/21", many: "5", Image: "lemon"),
        //            Store(name:"아보카도", Date:"2018/07/22",many: "15", Image: "avocado"),
        //            ]
        
        self.arrayList = []
        
        var stock = Store(name:"새우", UpDate: infoDate2, DownDate:"2018년 07월 22일", many: 20, saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222" )
        stock.Image = "shrimp"
        self.arrayList.append(stock)
        
        stock = Store(name:"레몬",  UpDate: infoDate2, DownDate:"2018년 07월 21일", many: 5,saveStyle: .Cold, TotalMany:20, Call:"010-4444-4444")
        stock.Image = "lemon"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate: infoDate2, DownDate:"2018년 07월 22일",many: 15, saveStyle: .temp, TotalMany:30, Call:"010-3333-2332")
        stock.Image = "avocado"
        self.arrayList.append(stock)
        
    }
}

class StoreChartTableViewController: UITableViewController {
    // UITableViewController = UIViewController , UITableViewController (테이블 뷰 관련), UTTableViewDelegate 제공
/**
     재고 목록 동적 테이블 뷰, 배열 사용
 */
    var modelStore = StoreModel()
    var modelStore2 = StoreModel_More()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 모델의 데이터 개수와 셀 개수 일치시키기
        return self.modelStore.arrayList.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = self.modelStore.arrayList[indexPath.row]
        let info2 = self.modelStore2.arrayList[indexPath.row]
        
        let proccell:StoreChartCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StoreChartCell
        let proccell2:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! StoreChartCell_More
        
        proccell2.more_labelName.text = info2.name
        proccell2.more_labelSaveStyle.text = info2.saveStyle.rawValue
        proccell2.more_labelUpDate.text = info2.UpDate
        proccell2.more_labelDownDate.text = info2.DownDate
        proccell2.more_labelMany.text = String(info2.many)
        proccell2.more_labelTotalMany.text = String(info2.TotalMany)
        proccell2.more_Call.text = info2.Call
        
        if let image2 = info2.Image {
            proccell2.more_ChartImage.image = UIImage(named: image2)
        }
        
        //proccell.labelDate.text = info.DownDate
        proccell.labelName.text = info.name
        proccell.labelMany.text = String(info.many)
        
        if let image = info.Image {
            proccell.viewImage.image = UIImage(named: image)
        }
      
       return proccell2
    }
    
//    @IBAction func taponButton(sender: UIButton){
//        let cell = sender.superview as! UITableViewCell
//        let indexPath = tableView.indexPathForCell(cell2)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        
        self.modelStore.selectedIndex = indexPath.row
        
        let segueStore = segue.destination as! StoreInfoController
        segueStore.modelStore = self.modelStore
    }


}

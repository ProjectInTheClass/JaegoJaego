import UIKit
import Foundation


enum saveStyle : String {
    case Fresh = "실온"
    case Cold = "냉장"
    case Ice = "냉동"
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
    
    
    // 재고 상세 데이터 생성자
    init(name:String, UpDate:String, DownDate:String, many:Int, saveStyle:saveStyle,  TotalMany:Int, Call:String?){
        self.name = name
        self.UpDate = UpDate
        self.DownDate = DownDate
        self.many = many
        self.saveStyle = saveStyle
    
        self.TotalMany = TotalMany + many
        self.Call = Call
        // 거래처와 이미지는 안받아도 됨, 전체 수량은 수량으로 계산
    }
}

// 재고 상세 데이터 표시
struct StoreModel {
    var selectedIndex:Int = 0
    var arrayList:Array<Store>
    
    // 들어온 날짜 = 당일 날짜
    var infoDate2:String = HomeDateModel.dateInfo()
    
    init(){
 
        
        self.arrayList = []
        
        var stock = Store(name:"새우", UpDate: infoDate2, DownDate:"2018년 07월 22일", many: 20, saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222" )
        stock.Image = "그래프"
        self.arrayList.append(stock)
        
        stock = Store(name:"레몬",  UpDate: infoDate2, DownDate:"2018년 07월 21일", many: 5,saveStyle: .Cold, TotalMany:20, Call:"010-4444-4444")
        stock.Image = "그래프"
        self.arrayList.append(stock)
        
        stock = Store(name:"아보카도",  UpDate: infoDate2, DownDate:"2018년 07월 22일",many: 15, saveStyle: .Fresh, TotalMany:30, Call:"010-3333-2332")
        stock.Image = "그래프"
        self.arrayList.append(stock)
        
    }
}

class StoreChartTableViewController: UITableViewController {

    // 재고 기본

    
    // 재고 상세
    var modelStore = StoreModel()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 모델의 데이터 개수와 셀 개수 일치시키기
        return self.modelStore.arrayList.count
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = self.modelStore.arrayList[indexPath.row]
        
        let proccell:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! StoreChartCell_More
        
        proccell.labelName.text = info.name
        proccell.labelSaveStyle.text = info.saveStyle.rawValue
        proccell.labelUpDate.text = info.UpDate
        proccell.labelDownDate.text = info.DownDate
        
        proccell.labelMany.text = String(info.many)
        proccell.labelTotalMany.text = String(info.TotalMany)
        proccell.Call.text = info.Call
        
        if let image2 = info.Image {
            proccell.ChartImage.image = UIImage(named: image2)
        }

       return proccell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        
        self.modelStore.selectedIndex = indexPath.row
        
        let segueStore = segue.destination as! StoreInfoController
        segueStore.modelStore = self.modelStore
    }


}

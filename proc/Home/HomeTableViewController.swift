import UIKit
import Foundation


// 폐기 목록 데이터 타입 정의
struct HomeThrowChart {
    var processImage: String?
    var name :String
    var saveStyle : String?
    var many: Int = 1
    var manyType:saveStyle
    
    init(name:String, many: Int, manyType:saveStyle){
        self.name = name
        self.many = many
        self.manyType = manyType
    }
}

// 폐기 데이터 배열 생성
struct HomedisposalChart_Model {
    var selectedIndex:Int = 0
    var HomeThrowArray:Array <HomeThrowChart>

    init() {
        self.HomeThrowArray = []
        
        var throwItem = HomeThrowChart(name: "바나나", many: 20, manyType: .Cold)
        self.HomeThrowArray.append(throwItem)
        
        throwItem = HomeThrowChart(name: "아보카도", many: 10, manyType: .Fresh)
        self.HomeThrowArray.append(throwItem)
        
        // 수량 순으로 정렬
        let sortedThrowItem = self.HomeThrowArray.sorted(by: { $0.many < $1.many})
        HomeThrowArray = sortedThrowItem
    }

}

class HomeTableViewController:UITableViewController {
    var ThrowArrayModel = HomedisposalChart_Model()
    
    // 출력하는 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ThrowArrayModel.HomeThrowArray.count
    }
    
    // UITableViewController 의 요소와 정의한 데이터들 일치시키기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let ThrowInfo = self.ThrowArrayModel.HomeThrowArray[indexPath.row]
        let ThrowCell: HomeChartCell = tableView.dequeueReusableCell(withIdentifier: "CellnameHomeThrow") as! HomeChartCell
        
        ThrowCell.ThrowName.text = ThrowInfo.name
        ThrowCell.ThrowMany.text = String(ThrowInfo.many)
        ThrowCell.ThrowManytype.text = ThrowInfo.manyType.rawValue
        
//        if let testimage = ThrowCell.ThrowProcessImage {
//            ThrowCell.ThrowProcessImage.image = UIImage(named: testimage)
//        }
//        if let testimage = ThrowCell.ThrowManytype {
//            ThrowCell.ThrowSavetype.image = UIImage(named: testimage)
//        }
        return ThrowCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        
        self.ThrowArrayModel.selectedIndex = indexPath.row
        
        let segueHome = segue.destination as! HomeTableViewController
        segueHome.ThrowArrayModel = self.ThrowArrayModel
    }
}

import UIKit
import Foundation


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
        //
        //        ThrowCell.ThrowName.text = ThrowInfo.name
        //        ThrowCell.ThrowMany.text = String(ThrowInfo.many)
        //        ThrowCell.ThrowSaveStyle.text = ThrowInfo.saveStyle.rawValue
        //
        //
        ////        if let image = ThrowCell.ThrowProcessImage {
        ////            ThrowCell.ThrowSaveStyle.image = UIImage(named: image)
        ////        }
        //        ThrowCell.ThrowManytype.text = ThrowInfo.manyType
        ////        if let testimage = ThrowCell.ThrowProcessImage {
        ////            ThrowCell.ThrowProcessImage.image = UIImage(named: testimage)
        ////        }
        ////        if let testimage = ThrowCell.ThrowManytype {
        ////            ThrowCell.ThrowSavetype.image = UIImage(named: testimage)
        ////        }
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

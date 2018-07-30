import UIKit
import Foundation


class HomeStoreTableViewController : UITableViewController {
    
    // 스케줄 데이터, 재고 데이터 가져오기
    var homeCallStore = StoreDatabase
    
    var ThrowArrayModel = HomedisposalChart_Model()
    //데이터 모델 선언
    
    
    // 출력하는 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ThrowArrayModel.HomeThrowArray.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    // UITableViewController 의 요소와 정의한 데이터들 일치시키기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let HomeStoreInfo = self.homeCallStore.arrayList[indexPath.row]
        let HomeStorecell: HomeStoreChartCell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
       
        HomeStorecell.HomeStoreName.text = HomeStoreInfo.name
        HomeStorecell.HomeStoreSaveStyle.text = HomeStoreInfo.saveStyle.rawValue
        //HomeStorecell.HomeStoreMany.text = String(HomeStoreInfo.many)
        //HomeStorecell.HomeStoreManytype.text = String(HomeStoreInfo.manytype)
        
        
        return HomeStorecell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        
        self.ThrowArrayModel.selectedIndex = indexPath.row
        
        let segueHome = segue.destination as! HomeStoreTableViewController
        segueHome.ThrowArrayModel = self.ThrowArrayModel
    }
}

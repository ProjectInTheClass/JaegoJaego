import UIKit
import Foundation


class HomeStoreTableViewController : UITableViewController {
    
    // 스케줄 데이터, 재고 데이터 가져오기
    var homeCallStore = StoreDatabase
    
    //데이터 모델 선언
    
    var homeStoreFilterByMany = [Store]()
    // 출력하는 섹션 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func ready () {
//        var tep =  homeCallStore.arrayList
//    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeCallStore.arrayList.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    // UITableViewController 의 요소와 정의한 데이터들 일치시키기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let HomeStoreInfo = self.homeCallStore.arrayList[indexPath.row]
        let HomeStorecell: HomeStoreChartCell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
        let storeManyDegree:String = " " + HomeStoreInfo.manytype
        
        HomeStorecell.HomeStoreName.text = HomeStoreInfo.name
        HomeStorecell.HomeStoreSaveStyle.text = HomeStoreInfo.saveStyle.rawValue
        HomeStorecell.HomeStoreMany.text = String(HomeStoreInfo.many) + storeManyDegree
        //HomeStorecell.HomeStoreManytype.text = HomeStoreInfo.manytype

        
        
        return HomeStorecell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath:IndexPath! = self.tableView.indexPath(for: cell)
        
        homeCallStore.selectedIndex = indexPath.row
        
        let segueHome = segue.destination as! HomeStoreTableViewController
       // segueHome.homeCallStore.arrayList = self.homeCallStore
    }
}

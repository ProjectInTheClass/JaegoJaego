import UIKit

class HomeStoreTableViewController : UITableViewController {
    private var viewModel = StoreViewModel()
    private var homeStoreFilterByMany: [Store] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        showLowStoresAtHome()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
}


extension HomeStoreTableViewController {
    func showLowStoresAtHome() {
        homeStoreFilterByMany = viewModel.returnStockLessItem()
        self.tableView.reloadData()
    }
}


extension HomeStoreTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeStoreFilterByMany.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let HomeStoreInfo = self.homeStoreFilterByMany[indexPath.row]
        let HomeStorecell: HomeStoreChartCell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
        let storeManyDegree:String = String(HomeStoreInfo.many) + " / \(HomeStoreInfo.TotalMany)" + " " + HomeStoreInfo.manytype
        
        HomeStorecell.HomeStoreName.text = HomeStoreInfo.name
        HomeStorecell.HomeStoreImage.image = UIImage(named: HomeStoreInfo.saveStyle.rawValue)
        HomeStorecell.HomeStoreMany.text = storeManyDegree
        
        return HomeStorecell
    }
}

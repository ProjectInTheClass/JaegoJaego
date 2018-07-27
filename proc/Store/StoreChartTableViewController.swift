import UIKit
import Foundation


class StoreChartTableViewController: UITableViewController {

    // 재고 기본

    
    // 재고 상세
    var modelStore = StoreDatabase
    
    
    override func viewDidLoad() {
//        tableView.reloadData()
        super.viewDidLoad()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 모델의 데이터 개수와 셀 개수 일치시키기
        return modelStore.arrayList.count
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = modelStore.arrayList[indexPath.row]
        
        let proccell:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2") as! StoreChartCell_More
        
        proccell.labelName.text = info.name
        proccell.labelSaveStyle.text = info.saveStyle.rawValue
        proccell.labelUpDate.text = info.UpDate
        proccell.labelDownDate.text = info.DownDate
        
        proccell.labelMany.text = String(info.many)
        proccell.labelManyType.text = String(info.manytype)
        proccell.labelTotalMany.text = String(info.TotalMany)
        proccell.Call.text = info.Call
        
        if let image2 = info.Image {
            proccell.ChartImage.image = UIImage(named: image2)
        }
        
        //tableView.reloadData()
        
       return proccell
    }

}

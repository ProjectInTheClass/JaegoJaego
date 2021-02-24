import UIKit
import Foundation

class HomeScheduleTableViewController : UITableViewController {
    private let homeCallSchedule = ScheduleDatabase
    // 출력하는 섹션 개수
    private var filterdata = [Schedule]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterdata = homeCallSchedule.ScheduleArray.filter{ $0.memodates == Date2String(date: Date(), format: "yyyyMMdd")}
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let homeScheduleCell:HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell

        homeScheduleCell.HomeScheduleTitle.text = filterdata[indexPath.row].memotitle
        
        return homeScheduleCell
    }
}

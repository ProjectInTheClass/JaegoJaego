import UIKit
import Foundation

class HomeScheduleTableViewController : UITableViewController {
    
     let homeCallSchedule = ScheduleDatabase
    // 출력하는 섹션 개수
    
    let dateformatter = DateFormatter()
    var sameDate = ""
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeCallSchedule.ScheduleArray.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    
    // UITableViewController 의 요소와 정의한 데이터들 일치시키기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let homeScheduleInfo = self.homeCallSchedule.ScheduleArray[indexPath.row]
        let homeScheduleCell: HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
       
        
        homeScheduleCell.HomeScheduleTitle.text = homeScheduleInfo.title
        homeScheduleCell.HomeScheduleMemo.text = homeScheduleInfo.memo
        
        //homeScheduleCell.HomeScheduleCount.text = homeScheduleInfo.dates
        
        
        return homeScheduleCell
    }
    
}

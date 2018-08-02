import UIKit
import Foundation

class HomeScheduleTableViewController : UITableViewController {
    
     let homeCallSchedule = ScheduleDatabase
    // 출력하는 섹션 개수
    
    let dateformatter = DateFormatter()
    var filterdata = [Schedule]()
    var sameDate = ""
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterdata = homeCallSchedule.ScheduleArray.filter{ $0.memodates == dateformatting() }
        self.tableView.reloadData()
    }
    
    /** 오늘 날짜를 출력 */
    func dateformatting() -> String{
        let formatterdate = Date()
        dateformatter.dateFormat = "yyyyMMdd"
        
        let todayDate = dateformatter.string(from: formatterdate)
        return todayDate
    }
  
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 모델의 데이터 개수와 셀 개수 일치시키기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdata.count
    }
    
    // UITableViewController 의 요소와 정의한 데이터들 일치시키기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let homeScheduleCell:HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
       print("filterdata = \(filterdata) \n")
        homeScheduleCell.HomeScheduleTitle.text = filterdata[indexPath.row].memotitle
        homeScheduleCell.HomeScheduleMemo.text = filterdata[indexPath.row].memotime
        // 날짜는 당일로 들어가니 따로 넣지 않음
        
        return homeScheduleCell

//        let homeScheduleInfo = self.homeCallSchedule.ScheduleArray[indexPath.row]
//        let homeScheduleCell: HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
//
//
//        homeScheduleCell.HomeScheduleTitle.text = homeScheduleInfo.memotitle
//        homeScheduleCell.HomeScheduleMemo.text = homeScheduleInfo.memodates
        
        //homeScheduleCell.HomeScheduleCount.text = homeScheduleInfo.dates
        
        
        //return homeScheduleCell
    }
    
}

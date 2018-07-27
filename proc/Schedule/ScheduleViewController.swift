

//import JTAppleCalendar
import UIKit
import Foundation
import FSCalendar

class ScheduleViewController :UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todayDate :UILabel?
    @IBOutlet weak var ourCalendar: FSCalendar!
    
    let tablecell = ScheduleTableViewController.ModelSchedule
    
    let formatter = DateFormatter()
    var selectedDate = ""

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablecell.ScheduleArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 테이블 셀에 정보 연결하기
        let tableNewInfo = self.tablecell.ScheduleArray[indexPath.row]
        let tableNewCell = tableView.dequeueReusableCell(withIdentifier: "littleScheduleCell") as! ScheduleLittleTableCell
        
        tableNewCell.littleTitle.text = "제목 : " + tableNewInfo.title
        tableNewCell.littleMemo.text = "메모 : " + tableNewInfo.memo
        tableNewCell.littleNumber.text = String(tableNewInfo.counts)
        // 날짜는 당일로 들어가니 따로 넣지 않음
        
        return tableNewCell
    }


    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> String{
        
//        // littleTable에 등록해놓은 날짜
//        let temp2 = tablecell.ScheduleArray.count
//        for i in temp2 {
//            var temp = tablecell.ScheduleArray[i].dates
//        }
        // 달력에서 날짜 클릭시 날짜 값 받아오기
        formatter.dateFormat = "yyyy.MM.dd" //이건 너가 정하렴
        selectedDate = formatter.string(from:date as Date)
         // 달력 클릭시 해당 날짜를 가져옴
       
        // "yyyyMMdd" 로 만들기
        let intDate:String = selectedDate.replacingOccurrences(of: ".", with: "")
        
        return intDate
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    

    
    
    

}

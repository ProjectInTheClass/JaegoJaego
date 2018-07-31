

//import JTAppleCalendar
import UIKit
import Foundation
import FSCalendar

class ScheduleViewController :UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var todayDate :UILabel?
    @IBOutlet weak var ourCalendar: FSCalendar!
    
    let tablecell = ScheduleDatabase.ScheduleArray // 저장된 값들을 가지고 있는 배열
    let formatter = DateFormatter()
    var selectedDate = ""
    let image = UIImage(named: "3-1")

    
    var filteredData: [Schedule] = [] // 달력과 메모 연결
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyyMMdd"
        selectedDate = formatter.string(from:date as Date)
        filteredData = tablecell.filter{ $0.dates == selectedDate }        // 달력과 같은 날짜를 filteredData 에 넣어주기
        table.reloadData()

    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
   

    //셀 핸들링
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let tableNewCell = tableView.dequeueReusableCell(withIdentifier: "littleScheduleCell") as! ScheduleLittleTableCell

        print(filteredData)
        tableNewCell.littleTitle.text = "제목 : " + filteredData[indexPath.row].title
        tableNewCell.littleMemo.text = "메모 : " + filteredData[indexPath.row].memo
        tableNewCell.littleNumber.text = String(indexPath.row + 1)
        // 날짜는 당일로 들어가니 따로 넣지 않음
        
        return tableNewCell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    

    
    
    

    
    
}

import UIKit
import Foundation
import FSCalendar

class ScheduleViewController :UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var calendar_table: UITableView!
    @IBOutlet weak var ourCalendar: FSCalendar!
    
    let tablecell = ScheduleDatabase // 저장된 값들을 가지고 있는 배열
    let formatter = DateFormatter()
   
    var selectedDate = ""

    var datesWithEvent = ScheduleDatabase.dateArray
    var filteredData: [Schedule] = [] // 달력과 메모 연결
    
    func dateformatting() -> String{
        let formatterdate = Date()
        formatter.dateFormat = "yyyyMMdd"

        let todayDate = formatter.string(from: formatterdate)
        return todayDate
    }
    
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition){
//
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyyMMdd"
//    dateFormatter.locale = Locale.init(identifier: "fa_IR")
//
//    for dateStr in date{
//        if(dateFormatter.string(from: date) == dateStr)
//            {
//                cell.eventIndicator.numberOfEvents = 1
//                cell.eventIndicator.isHidden = false
//                cell.eventIndicator.color = UIColor.blue
//            }
//        }
//    }


    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        //let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString){
            return 1
        }
        return 0
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyyMMdd"
        selectedDate = formatter.string(from:date as Date)
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }        // 달력과 같은 날짜를 filteredData 에 넣어주기
        
        self.calendar_table.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
   

    //셀 핸들링
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableNewCell = tableView.dequeueReusableCell(withIdentifier: "littleScheduleCell" ,for:indexPath) as! ScheduleLittleTableCell
        tableNewCell.littlememo.text = filteredData[indexPath.row].memotitle
        tableNewCell.littletime.text = filteredData[indexPath.row].memotime
        tableNewCell.littlestack.image = UIImage(named: "schedulestaffimg")
        tableNewCell.littleJaegom.image = UIImage(named: "gaegom_skyblue")
        // 날짜는 당일로 들어가니 따로 넣지 않음
        return tableNewCell
    }
    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let temp = tablecell.ScheduleArray[indexPath.row]
        let indexofA = tablecell.ScheduleArray.index(of: temp)
        
        filteredData.remove(at: indexPath.row)
        tablecell.ScheduleArray.remove(at: indexofA!)

        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.calendar_table.reloadData()
        
    }
    func setNavigationBar(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        self.setNavigationBar()
        super.viewDidLoad()
        calendar_table.dataSource = self
        calendar_table.delegate = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedDate = dateformatting()
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }
//
//        if filteredData != nil {
//           datesWithEvent = tablecell.ScheduleArray.filter({$0.memodates == selectedDate})
//        }
        
        calendar_table.reloadData()
    }
    
}

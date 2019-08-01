import UIKit
import Foundation
import FSCalendar

class ScheduleViewController : UIViewController {
    
    @IBOutlet weak var calendar_table: UITableView!
    @IBOutlet weak var ourCalendar: FSCalendar!
    
    let tablecell = ScheduleDatabase // 저장된 값들을 가지고 있는 배열
    let formatter = DateFormatter()
    var selectedDate = ""
    var datesWithEvent = ScheduleDatabase.dateArray
    var filteredData: [Schedule] = [] // 달력과 메모 연결
    
    override func viewDidLoad() {
        self.setNavigationBar()
        super.viewDidLoad()
        
        calendar_table.dataSource = self
        calendar_table.delegate = self
        
        dataReload()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        selectedDate = dateFormatting(data: Date())
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }

        dataReload()
    }
}


extension ScheduleViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableNewCell = tableView.dequeueReusableCell(withIdentifier: "littleScheduleCell" ,for:indexPath) as! ScheduleLittleTableCell
        
        tableNewCell.littlememo.text = String(filteredData[indexPath.row].memotitle)
        tableNewCell.littleJaegom.image = UIImage(named: "gaegom_skyblue")
        // 날짜는 당일로 들어가니 따로 넣지 않음
        return tableNewCell
    }
    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let temp = tablecell.ScheduleArray[indexPath.row]
        let indexofA = tablecell.ScheduleArray.index(of: temp)
        
        filteredData.remove(at: indexPath.row)
        tablecell.ScheduleArray.remove(at: indexofA!)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.calendar_table.reloadData()
    }
}

extension ScheduleViewController : FSCalendarDataSource, FSCalendarDelegate {
    func dataReload(){
        self.ourCalendar.reloadData()
        self.calendar_table.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition){
        let d = dateFormatting(data: date)
        
        for dateStr in datesWithEvent{
            if(d == dateStr){
                cell.eventIndicator.numberOfEvents = 1
                cell.eventIndicator.isHidden = false
                cell.eventIndicator.color = UIColor.blue
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateFormatting(data: date)
        if self.datesWithEvent.contains(dateString){
            return 1
        }
        return 0
    }
    
    // 선택한 날짜와 같은 날짜의 데이터를 filteredData(테이블뷰) 에 넣어주기
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = dateFormatting(data: date)
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }
        
        self.calendar_table.reloadData()
    }
}

extension ScheduleViewController {
    func dateFormatting(data : Date) -> String{
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: data)
    }
    
    func setNavigationBar(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
}

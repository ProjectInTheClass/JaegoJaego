

//import JTAppleCalendar
import UIKit
import Foundation
import FSCalendar

class ScheduleViewController :UIViewController, FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var todayDate :UILabel?
    @IBOutlet weak var ourCalendar: FSCalendar!
    
    let tablecell = ScheduleDatabase // 저장된 값들을 가지고 있는 배열
    let formatter = DateFormatter()
   
    var selectedDate = ""
    let image = UIImage(named: "3-1")

    
    var filteredData: [Schedule] = [] // 달력과 메모 연결
    
    func dateformatting() -> String{
        let formatterdate = Date()
        formatter.dateFormat = "yyyyMMdd"
        
        let todayDate = formatter.string(from: formatterdate)
        return todayDate
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyyMMdd"
        selectedDate = formatter.string(from:date as Date)
        
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }        // 달력과 같은 날짜를 filteredData 에 넣어주기
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
        print("tablenewcell = \(tableNewCell.littlememo )")
     
        tableNewCell.littlememo.text = filteredData[indexPath.row].memotitle
        tableNewCell.littletime.text = filteredData[indexPath.row].memotime
        // 날짜는 당일로 들어가니 따로 넣지 않음
        
        return tableNewCell
    }
    
    // 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        var temp = tablecell.ScheduleArray[indexPath.row]
        
        let indexofA = tablecell.ScheduleArray.index(of: temp)
        
        filteredData.remove(at: indexPath.row)
        tablecell.ScheduleArray.remove(at: indexofA!)

        tableView.deleteRows(at: [indexPath], with: .automatic)
        table.reloadData()
        
    }
    func setNavigationBar(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }

    override func viewDidLoad() {
        table.reloadData()
        self.setNavigationBar()
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        selectedDate = dateformatting()
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }
        

        //print("viewDidAppear filteredData = \(filteredData)")
        self.table.reloadData()
        super.viewDidAppear(animated)
    }

    
    
    

    
    
}

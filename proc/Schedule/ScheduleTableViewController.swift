//
//  ScheduleTableViewController.swift
//  proc
//
//  Created by 성다연 on 2018. 10. 18..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit
import Foundation
import FSCalendar

class ScheduleTableViewController: UITableViewController,FSCalendarDataSource, FSCalendarDelegate {
    @IBOutlet weak var outCalender: FSCalendar!
    @IBOutlet weak var calContainer: UIView!
    
    let tablecell = ScheduleDatabase // 저장된 값들을 가지고 있는 배열
    let formatter = DateFormatter()
    
    var selectedDate = ""
    
    var datesWithEvent = ScheduleDatabase.dateArray
    var filteredData: [Schedule] = [] // 달력과 메모 연결
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedDate = dateformatting()
        filteredData = tablecell.ScheduleArray.filter{ $0.memodates == selectedDate }
        
        print("loading filteredData...\(filteredData.count)")
        self.tableView.reloadData()
    }
    
    /** 오늘 날짜 출력 */
    func dateformatting() -> String{
        let formatterdate = Date()
        formatter.dateFormat = "yyyyMMdd"
        
        let todayDate = formatter.string(from: formatterdate)
        return todayDate
        
    }
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
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
        
        self.tableView.reloadData()
        
    }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    //셀 핸들링
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableNewCell:ScheduleLittleTableCell = tableView.dequeueReusableCell(withIdentifier: "littleScheduleCell") as! ScheduleLittleTableCell
        
        tableNewCell.littlememo.text = filteredData[indexPath.row].memotitle
        tableNewCell.littletime.text = filteredData[indexPath.row].memotime
        // 날짜는 당일로 들어가니 따로 넣지 않음
        return tableNewCell
    }
    
    // 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let temp = tablecell.ScheduleArray[indexPath.row]
        let indexofA = tablecell.ScheduleArray.index(of: temp)
        
        filteredData.remove(at: indexPath.row)
        tablecell.ScheduleArray.remove(at: indexofA!)
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.reloadData()
        
    }
    func setNavigationBar(){
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }

    override func viewDidLoad() {
        self.setNavigationBar()
        self.tableView.reloadData()
        super.viewDidLoad()
    }
    
   
}

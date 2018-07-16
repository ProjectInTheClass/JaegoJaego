//
//  ViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 5..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit
//import FSCalender

class ViewController: UIViewController /*, FSCalenderDelegrate, FSCalenderDataSource*/ {
   // @IBOutlet weak var calender: FSCalender!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
        calender.cellshape = .Rectangle
        calender.allowMultipleSelection = true
        calender.clipsToBounds = true
        
        calender.delegate = self
        calender.dataSource = self
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    //각 날짜에 특정 문자열을 표시할 수 있음
    func calender(calender: FSCalender, subtitleForDate date: NSDate) -> String? {
        return "W"
    }
    // 특정 날짜를 선택했을 때, 발생하는 이벤트를 여기서 처리함
    func calender(calender: FSCalender, didSelectDate date: NSDate){
        print(date)
    }
    // 스와이프를 통해서 다음 달의 달력으로 넘어갈 때 발생하는 이벤트를 이곳에서 처리
    func calendarCurrentMonthDidChange(calender: FSCalender){
        print(calender)
    }
     */
    /*
    //달력 계산에 사용되는 연, 월, 일 정보들을 현재 시점으로 설정하는 함수
    var year0=1
    var month0=1
    var day0=1
    var weekday0=1
    var lastdayOfMonthArray : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    mutating func giveCurrentDate(){
        year0 = NSCalendar.current.component(.year, from: Date())
        month0 = NSCalender.current.component(.month, from: Date())
        day0 = NSCalender.current.component(.day, from: Date())
        weekday0 = NSCalender.current.component(.weekday, from: Date())

    }*/
    
    
}


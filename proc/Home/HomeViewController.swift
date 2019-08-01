 
 import UIKit
 import Foundation
 import FSCalendar
 
 class HomeViewController: UIViewController {
    @IBOutlet weak var needLabelView: UIView!
    @IBOutlet weak var noticeScheduleView: UIView!
    @IBOutlet weak var noticeNeedTV: UITableView!
    @IBOutlet weak var noticeScheduleTV: UITableView!
    @IBOutlet weak var noticeTodayDate :UILabel?
   
    var homeCallStore = StoreDatabase
    var homeStoreFilterByMany : [Store] = []
    
    var homeCallSchedule = ScheduleDatabase
    var homeSchedulefilterData : [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        giveDelegate()
        controlNeedLableView()
        
        noticeTodayDate?.text! = todayDateFormat()
        // 부족한 수량 보여주기
        homeStoreFilterByMany = homeCallStore.showLessManyItem()
        // 오늘날에 해당하는 일정 보여주기
        homeSchedulefilterData = homeCallSchedule.ScheduleArray.filter{ $0.memodates == scheduleDateFormat()}
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloading()
    }
}
 
 extension HomeViewController {
    func reloading(){
        self.noticeNeedTV.rowHeight = UITableView.automaticDimension
        self.noticeNeedTV.estimatedRowHeight = UITableView.automaticDimension
        
        self.noticeScheduleTV.rowHeight = UITableView.automaticDimension
        self.noticeScheduleTV.estimatedRowHeight = UITableView.automaticDimension
        
        self.noticeNeedTV.reloadData()
        self.noticeScheduleTV.reloadData()
    }
    
    func giveDelegate(){
        self.noticeNeedTV.delegate = self
        self.noticeNeedTV.dataSource = self
        
        self.noticeScheduleTV.delegate = self
        self.noticeScheduleTV.dataSource = self
    }
    
    func todayDateFormat() -> String{
        let formatter = DateFormatter()
        let formatterdate = Date()
        
        formatter.dateFormat = "MM월 dd일"
        
        let todayDate = formatter.string(from: formatterdate)
        return todayDate
    }
    
    func scheduleDateFormat() -> String {
        let formatter = DateFormatter()
        let formatterdate = Date()
        formatter.dateFormat = "yyyyMMdd"
        
        let todayDate =  formatter.string(from: formatterdate)
        return todayDate
    }
    
    func controlNeedLableView(){
        self.needLabelView.layoutSubviews()
        needLabelView.layer.cornerRadius = 15
        needLabelView.layer.borderColor = UIColor.init(hex: "#85BECA").cgColor
        needLabelView.layer.borderWidth = 3
    }
 }
 
 extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int?
        
        if tableView == noticeNeedTV {
            count = homeStoreFilterByMany.count
        }
        else {
            count = homeSchedulefilterData.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView == noticeNeedTV {
            let HomeStoreInfo = self.homeStoreFilterByMany[indexPath.row]
            let HomeStorecell: HomeStoreChartCell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
            let storeManyDegree:String = " " + HomeStoreInfo.manytype
            
            HomeStorecell.HomeStoreName.text = HomeStoreInfo.name
            //proccell.ChartImage.image = UIImage(named: image2)
            HomeStorecell.HomeStoreImage.image = UIImage(named: HomeStoreInfo.saveStyle.rawValue)
            HomeStorecell.HomeStoreMany.text = String(HomeStoreInfo.many) + " / \(HomeStoreInfo.TotalMany)" + storeManyDegree
            //HomeStorecell.HomeStoreManytype.text = HomeStoreInfo.manytype
            
            
            cell = HomeStorecell
        }
        else {
            let homeScheduleCell:HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
            
            homeScheduleCell.HomeScheduleTitle.text = homeSchedulefilterData[indexPath.row].memotitle
//            homeScheduleCell.HomeScheduleMemo.text = homeSchedulefilterData[indexPath.row].memotime
            // 날짜는 당일로 들어가니 따로 넣지 않음
            
            cell = homeScheduleCell
        }
        
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == noticeNeedTV {
            return 56.0
        }else{
            return 50.0
        }
//        return UITableViewAutomaticDimension
    }
 }
 
 extension HomeViewController : UITableViewDelegate {
    
 }
 

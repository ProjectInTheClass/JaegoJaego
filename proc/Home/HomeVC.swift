 
 import UIKit
 import Foundation
 import FSCalendar
 
 class HomeViewController: UIViewController {
    @IBOutlet weak var needLabelView: UIView!
    @IBOutlet weak var noticeScheduleView: UIView!
    @IBOutlet weak var noticeNeedTV: UITableView!
    @IBOutlet weak var noticeScheduleTV: UITableView!
    @IBOutlet weak var noticeTodayDate :UILabel!
   
    private var viewModel = StoreViewModel()
    private var homeStoreFilterByMany : [Store] = []
    
    private var homeCallSchedule = ScheduleDatabase
    private var homeSchedulefilterData : [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubViews()
        setUpDelegate()
        setUpNeedLableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloading()
    }
}
 
 extension HomeViewController {
    func setSubViews(){
        noticeTodayDate.text = Date2String(date: Date(), format: "MM월 dd일")
        homeStoreFilterByMany = viewModel.returnStockLessItem()
        homeSchedulefilterData = homeCallSchedule.ScheduleArray.filter{
            $0.memodates == Date2String(date: Date(), format: "yyyyMMdd")} // 오늘날에 해당하는 일정 보여주기
        
        noticeNeedTV.rowHeight = UITableView.automaticDimension
        noticeNeedTV.estimatedRowHeight = UITableView.automaticDimension
        noticeScheduleTV.rowHeight = UITableView.automaticDimension
        noticeScheduleTV.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func setUpDelegate(){
        noticeNeedTV.delegate = self
        noticeNeedTV.dataSource = self
        noticeScheduleTV.delegate = self
        noticeScheduleTV.dataSource = self
    }
    
    func setUpNeedLableView(){
        needLabelView.layoutSubviews()
        needLabelView.layer.cornerRadius = 15
        needLabelView.layer.borderColor = UIColor.init(hex: "#85BECA").cgColor
        needLabelView.layer.borderWidth = 3
    }
    
    func reloading(){
        noticeNeedTV.reloadData()
        noticeScheduleTV.reloadData()
    }
 }
 
 
 extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == noticeNeedTV ? homeStoreFilterByMany.count : homeSchedulefilterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == noticeNeedTV {
            let HomeStoreInfo = self.homeStoreFilterByMany[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HStoreCell") as! HomeStoreChartCell
            let storeManyDegree = "\(HomeStoreInfo.many) + \(HomeStoreInfo.TotalMany) " + HomeStoreInfo.manytype
            
            cell.HomeStoreName.text = HomeStoreInfo.name
            cell.HomeStoreImage.image = UIImage(named: HomeStoreInfo.saveStyle.rawValue)
            cell.HomeStoreMany.text = storeManyDegree
            
            return cell
        } else {
            let cell:HomeScheduleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HScheduleCell") as! HomeScheduleTableViewCell
            cell.HomeScheduleTitle.text = homeSchedulefilterData[indexPath.row].memotitle
            
            return cell
        }
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == noticeNeedTV ? 56.0 : 50.0
    }
 }


import UIKit
import Foundation

// search 바 포함
class StoreChartTableViewController: UITableViewController, UISearchBarDelegate {
    
    // 재고 기본

    @IBOutlet weak var location_table: UITableView!
    @IBOutlet weak var searchbar : UISearchBar!
    

    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var labelSaveStyle:UILabel!
    @IBOutlet weak var ChartImage:UIImageView!
    @IBOutlet weak var labelUpDate:UILabel!
    @IBOutlet weak var labelDownDate:UILabel!
    @IBOutlet weak var labelMany:UILabel!
    @IBOutlet weak var labelManyType:UILabel!
    @IBOutlet weak var labelTotalMany:UILabel!
    @IBOutlet weak var Call:UILabel!
    
    // 재고 상세
    var infoDateAdd:String = HomeDateModel.dateInfo()
    var dataFilePath: String?
    
    var location_name_array = StoreDatabase //[String]() // 원본(위치정보)를 가지는 배열
    var searchfilterData:[Store] = [] // 필터링된 결과를 저장할 배열

 
    
    // searchbar 관련 메소드
    func searchBar(_ searchbar: UISearchBar, textDidChange searchText:String){
        
        searchfilterData = searchText.isEmpty ? location_name_array.arrayList : location_name_array.arrayList.filter{ $0.name.range(of: searchText) != nil}
        location_table.reloadData() // 필터링한 데이터를 테이블뷰로 설정
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = true // 취소 버튼
    }
    
    // 취소버튼 클릭 시 키보드 닫히고 검색어 초기화
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchbar.showsCancelButton = false
        self.searchbar.text = ""
        self.searchbar.resignFirstResponder()
    }
    
    //table section 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0 :
            return "폐기 물품"
        case 1 :
            return "당일 마감"
        case 2 :
            return "3일 이상"
        default:
            return "7일 이상"
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchfilterData.count
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        searchfilterData = location_name_array.arrayList
        self.tableView.reloadData()
        
        super.viewDidAppear(animated)
       
    }
    
    // 재고 삭제 코드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        
        let temp = searchfilterData[indexPath.row]
        let indexofA = location_name_array.arrayList.index(of: temp)

        searchfilterData.remove(at: indexPath.row)
        location_name_array.arrayList.remove(at: indexofA!)

        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.reloadData()

    }

    override func viewDidLoad() {

        searchfilterData = location_name_array.arrayList
        
        
        // search bar
        location_table.dataSource = self
        location_table.delegate = self
        searchbar.placeholder = "재고 이름을 검색하세요" // hint 등록
        
        location_table.tableHeaderView = searchbar
        location_table.estimatedSectionHeaderHeight = 50
        searchbar.delegate = self // searchbar 이벤트 처리
        self.tableView.reloadData()
        super.viewDidLoad()
        
        //        // 아카이브 코드
        //        let fileManager = FileManager.default
        //        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, userDomainMask, true)
        //        let docsDir = dirPath[0] as NSString
        //        dataFilePath = docsDir.appendingPathComponent("data.archive")
        //
        //        if fileManager.fileExists(atPath: dataFilePath!){
        //            let user = NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath!) as! Store
        //            labelName.text = user.name
        //            labelSaveStyle.text = user.saveStyle.rawValue
        //            // 이미지 자리
        //            labelUpDate.text = user.UpDate
        //            labelDownDate.text = user.DownDate
        //            labelMany.text = String(user.many)
        //            labelManyType.text = user.manytype
        //            labelTotalMany.text = String(user.TotalMany)
        //            Call.text = user.Call
        //        }
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = searchfilterData[indexPath.row]
        let proccell:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2IngredientBig") as! StoreChartCell_More

        // cell
        proccell.labelName.text = info.name
        proccell.labelSaveStyle.text = info.saveStyle.rawValue
        proccell.labelUpDate.text =  info.UpDate
        proccell.labelDownDate.text = info.DownDate
        
        proccell.labelMany.text = String(info.many)
        proccell.labelManyType.text = String(info.manytype)
        proccell.labelTotalMany.text = String(info.TotalMany)
//        proccell.Call.text = info.Call
        
        if let image2 = info.Image {
            proccell.ChartImage.image = UIImage(named: image2)
        }
        
        return proccell
    }
    
}



import UIKit
import Foundation

// search 바 포함
class StoreChartTableViewController: UITableViewController, UISearchBarDelegate {
    
    var storemodel = StoreDatabase
    
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
    
    var infoDateAdd:String = HomeDateModel.dateInfo()
    var dataFilePath: String?

    var location_name_array = StoreDatabase
    
    // 재고 목록 4가지
    var array00ToTrash:[Store] = []
    var array01Today:[Store] = []
    var array02D3:[Store] = []
    var array03D7:[Store] = []
    
    // 필터링된 결과를 저장할 배열
    var searchfilterData0:[Store] = []
    var searchfilterData1:[Store] = []
    var searchfilterData2:[Store] = []
    var searchfilterData3:[Store] = []
    
    
    func updateArraysFromModel() {
        array00ToTrash = StoreDatabase.storesUntilDate(fromDays: -1, toDays: 1)
        array01Today = StoreDatabase.storesUntilDate(fromDays: 1, toDays: 3)
        array02D3 = StoreDatabase.storesUntilDate(fromDays: 3, toDays: 7)
        array03D7 = StoreDatabase.storesUntilDate(fromDays: 7, toDays: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*       // 화면 전환하기 전에 있는 소스
         segue.source
         // 타겟
         segue.destination
         // segue는 모두 identifier를 가지고 있고 이를 이프문을 이용해서 구분해 줌
         segue.identifier
         */
        // 기본적으로 UIViewController로 상속 -> 캐스팅을 해주어야함(PlayerViewController로)
        // destination에 PlayerViewController가 있다는 선언 없을 시에는 앱이 죽음
        // ? => vcPlayer가 Optional로 선언 -> if let으로 확인 해야함
        let viewcell = sender as! UITableViewCell // sender를 cell로 다운 캐스팅
        let indexPath:IndexPath! = self.tableView.indexPath(for: viewcell)
        var store:Store?
        
        switch indexPath.section {
        case 0:
            store = self.searchfilterData0[indexPath.row]
        case 1:
            store = self.searchfilterData1[indexPath.row]
        case 2:
            store = self.searchfilterData2[indexPath.row]
        case 3:
            store = self.searchfilterData3[indexPath.row]
        default:
            store = nil
        }
        
        let singleIndex = self.storemodel.arrayList.index(of: store!)!
        self.storemodel.selectedIndex = singleIndex
    }

    
    
    override func viewDidLoad() {
        // search bar
        location_table.dataSource = self
        location_table.delegate = self
        searchbar.placeholder = "재고 이름을 검색하세요" // hint 등록
        
        location_table.tableHeaderView = searchbar
        location_table.estimatedSectionHeaderHeight = 50
        searchbar.delegate = self // searchbar 이벤트 처리
        location_name_array.sameStoreMany()
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
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        
        updateArraysFromModel()
        
        searchfilterData0 = array00ToTrash.sorted(by: {$0.DownDate < $1.DownDate })
        searchfilterData1 = array01Today.sorted(by: {$0.DownDate < $1.DownDate })
        searchfilterData2 = array02D3.sorted(by: {$0.DownDate < $1.DownDate })
        searchfilterData3 = array03D7.sorted(by: {$0.DownDate < $1.DownDate })
        
        self.tableView.reloadData()

    }
    
    // searchbar 관련 메소드
    func searchBar(_ searchbar: UISearchBar, textDidChange searchText:String){
        
        searchfilterData0 = searchText.isEmpty ? array00ToTrash : array00ToTrash.filter{ $0.name.range(of: searchText) != nil}
        searchfilterData1 = searchText.isEmpty ? array01Today : array01Today.filter{ $0.name.range(of: searchText) != nil}
        searchfilterData2 = searchText.isEmpty ? array02D3 : array02D3.filter{ $0.name.range(of: searchText) != nil}
        searchfilterData3 = searchText.isEmpty ? array03D7 : array03D7.filter{ $0.name.range(of: searchText) != nil}

        location_table.reloadData() // 필터링한 데이터를 테이블뷰로 설정
    }
    
    
    // 취소버튼 클릭 시 키보드 닫히고 검색어 초기화
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        searchbar.resignFirstResponder()
    }
  
    
    //table section 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        switch section {
        case 0 :
            return "전체수량  : \(location_name_array.arrayList.count) 개"
        case 1 :
            if searchfilterData0.count == 0 {
                return "폐기 물품"
            }
            return "폐기 물품  : \(searchfilterData0.count) 개"
        case 2 :
            if searchfilterData1.count == 0 {
                return "당일 마감 물품"
            }
            return "당일 마감  : \(searchfilterData1.count) 개"
        case 3 :
            if searchfilterData2.count == 0 {
                return "3일 이상 물품"
            }
            return "3일 이상  : \(searchfilterData2.count) 개"
        default:
            if searchfilterData3.count == 0 {
                return "7일 이상 물품"
            }
            return "7일 이상  : \(searchfilterData3.count) 개 "
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rValue = 0
        
        switch section {
        case 0 :
            rValue = 0
        case 1:
            rValue =  self.searchfilterData0.count
        case 2:
            rValue =  self.searchfilterData1.count
        case 3:
            rValue =  self.searchfilterData2.count
        case 4:
            rValue =  self.searchfilterData3.count
        default:
            rValue = 0
        }
        return rValue
    }
    
    
    
    /** 전화걸기 함수 */
    @IBAction func phoenCallBtn(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: cell)
        
        
        if location_name_array.arrayList[(indexPath?.row)!].Call != nil {
            let temp = location_name_array.arrayList[(indexPath?.row)!].Call!
            
            if let phoneCallURL = URL(string: "tel://\(temp)") {
                
                let application:UIApplication = UIApplication.shared
                
                if (application.canOpenURL(phoneCallURL)) {
                    
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                    
                }
                
            }
            
        }
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var arrayStore:[Store]!
        
        if indexPath.section == 1 {
            arrayStore =  searchfilterData0
        }
        else if indexPath.section == 2 {
            arrayStore = searchfilterData1
        }
        else if indexPath.section == 3 {
            arrayStore =  searchfilterData2
        }
        else if indexPath.section == 4 {
            arrayStore =  searchfilterData3
        }
        

        print("arrayStore sort : \(arrayStore)")
        let store = arrayStore[indexPath.row]
        
        let proccell:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2IngredientBig") as! StoreChartCell_More

        // cell
        proccell.labelName.text = store.name
        proccell.labelSaveStyle.text = store.saveStyle.rawValue
        proccell.labelUpDate.text =  store.UpDate
        proccell.labelDownDate.text = store.DownDate
        proccell.labelMany.text = String(store.many)
        proccell.labelManyType.text = String(store.manytype)
        proccell.labelTotalMany.text = String(store.TotalMany)
      
        
        if let image2 = store.Image {
            proccell.ChartImage.image = UIImage(named: image2)
        }
        
        return proccell
    }
    
    
    /** 재고 삭제 코드 */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            
            let store = searchfilterData0[indexPath.row]
            let indexofA = location_name_array.arrayList.index(of: store)
            
            searchfilterData0.remove(at: indexPath.row)
            location_name_array.arrayList.remove(at: indexofA!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        else if indexPath.section == 1 {
            let store = searchfilterData1[indexPath.row]
            let indexofA = location_name_array.arrayList.index(of: store)
            
            searchfilterData1.remove(at: indexPath.row)
            location_name_array.arrayList.remove(at: indexofA!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        else if indexPath.section == 2 {

            let store = searchfilterData2[indexPath.row]
            let indexofA = location_name_array.arrayList.index(of: store)
            
            searchfilterData2.remove(at: indexPath.row)
            location_name_array.arrayList.remove(at: indexofA!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        else if indexPath.section == 3 {
            
            let store = searchfilterData3[indexPath.row]
            let indexofA = location_name_array.arrayList.index(of: store)
            
            searchfilterData3.remove(at: indexPath.row)
            location_name_array.arrayList.remove(at: indexofA!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }

        location_name_array.sameStoreMany()
       self.tableView.reloadData()

    }
}



import UIKit
import Foundation


class StoreChartTableViewController: UITableViewController {
    
    // 재고 기본

    

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
    var modelStore = StoreDatabase
    
    var dataFilePath: String?
    override func viewDidLoad() {
        //        tableView.reloadData()
        super.viewDidLoad()
        // 아카이브 코드
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
    
//    @IBAction func saveData(_ sender: Any){
//        let user = Store(name: name.text! , UpDate: infoDate2, DownDate:"2018년 07월 22일", many: 20, manytype:"통", saveStyle: .Cold, TotalMany:80, Call:"010-1111-2222" )
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 모델의 데이터 개수와 셀 개수 일치시키기
        return modelStore.arrayList.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        modelStore.arrayList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        print("modelstore = \(modelStore.arrayList)")
        print("stockbase = \(StoreDatabase.arrayList)")
    }
    

//    // 재고 삭제 코드
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
//        // 데이터를 삭제
//        modelStore.arrayList.remove(at: indexPath.row)
//        // 테이블 뷰에서 셀 삭제
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let info = modelStore.arrayList[indexPath.row]
        
        let proccell:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2IngredientBig") as! StoreChartCell_More
        
        proccell.labelName.text = info.name
        proccell.labelSaveStyle.text = info.saveStyle.rawValue
        proccell.labelUpDate.text = info.UpDate
        proccell.labelDownDate.text = info.DownDate
        
        proccell.labelMany.text = String(info.many)
        proccell.labelManyType.text = String(info.manytype)
        proccell.labelTotalMany.text = String(info.TotalMany)
        proccell.Call.text = info.Call
        
        if let image2 = info.Image {
            proccell.ChartImage.image = UIImage(named: image2)
        }
        
        //tableView.reloadData()
        
        return proccell
    }
    
}

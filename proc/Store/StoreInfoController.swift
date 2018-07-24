import UIKit
import Foundation

class StoreInfoController : UIViewController {
    /**
     재고 목록 상세 창
 */
    
    var modelStore:StoreModel!

    @IBOutlet weak var labelName:UILabel!
    @IBOutlet weak var viewImage:UIImageView!
    @IBOutlet weak var labelDate:UILabel!
    @IBOutlet weak var labelMany:UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoStore = modelStore.arrayList[modelStore.selectedIndex]
        
        labelName.text = infoStore.name
        labelDate.text = infoStore.DownDate
        labelMany.text = String(infoStore.many)
        //viewImage.image = infoStore.Image
        
        if let fileName = infoStore.Image {
            viewImage.image = UIImage(named: fileName)
        }
    }

    @IBAction func onClick(sender: AnyObject){
        
    }
    
    
    @IBAction func touchClose(){
        let 완료 = {() -> Void in
            print("성공적 완료")
        }
        
//        self.dismiss(animated: true, completion: 완료)
    }
    
    @IBAction func touchBack (_ sender: Any){
        self.navigationController?.popToRootViewController(animated: true)
    }
/*
    
    var modelMusic = StoreModel()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 */
}

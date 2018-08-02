//
//  StockDetailViewController.swift
//  proc
//
//  Created by swuad_28 on 2018. 8. 2..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit
//var coredata = StoreDatabase
var stockDetail = StoreDatabase

class StockDetailViewController: UIViewController {
    
//    var temp = location_name_array.arrayList[(indexPath?.row)!].many!
//    var temp2 = location_name_array.arrayList[(indexPath?.row)!].!
    

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var save: UILabel!
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var graimage: UIImageView!
    @IBOutlet weak var totalnum: UILabel!
    
    @IBOutlet weak var num: UITextField!
  
    @IBOutlet weak var completebutton: UIButton!
   
    @IBAction func Completebut(_ sender: Any) {
        let store = stockDetail.arrayList[stockDetail.selectedIndex]
// proc.Store = (Store)
//        store.many = store.many - Int(self.num.text!)!
        
        // 해당 재고 수량을 넘어선 개수를 입력하면 숫자가 바뀌지 못하게 막음
        if store.many - Int(self.num.text!)! <= 0 {
            if store.many - Int(self.num.text!)! == 0 {
                stockDetail.arrayList.remove(at: stockDetail.arrayList.index(of: store)!)
            }
            print("Not allowed")
        }
        else {
           store.many = store.many - Int(self.num.text!)!
         //   stockDetail.arrayList.remove(at: store)
//            let store = searchfilterData0[indexPath.row]
//            let indexofA = location_name_array.arrayList.index(of: store)
//
//            //print("removing data0 = \(searchfilterData0)")
//            searchfilterData0.remove(at: indexPath.row)
//            location_name_array.arrayList.remove(at: indexofA!)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.tableView.reloadData()
        }
       stockDetail.sameStoreMany()
        
        self.navigationController?.popViewController(animated: true)
        
//        if coredata.arrayList[(indexPath?.row)!].many != nil {
//            var temp = location_name_array.arrayList[(indexPath?.row)!].Call!
//            print("temp = \(temp)")
//
//
////    }
//        if coredata.arrayList[IndexPath].many != nil {
//            var temp = coredata.arrayList[(IndexPath)]
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let infoStock = stockDetail.arrayList[stockDetail.selectedIndex]
        
        graimage.image = UIImage(named: infoStock.Image!)
        name.text = infoStock.name
        day1.text = infoStock.UpDate
        day2.text = infoStock.DownDate
    
        
        //num.text = String(infoStock.many)
        totalnum.text = String(infoStock.TotalMany)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//import UIKit
//import Foundation
//
//class PlayerViewController : UIViewController {
//    /**
//     앞에서 넘겨 받아서 참조만 하는 음악 모델, 내부에 Music Info가 있다
//     */
//    var modelMusic:MusicModel! // 나중에 넘겨 받을 것임으로 지금 당장은 값이 없고 나중에 값이 바뀔 수 있다. 우리가 사용하는 시점에는 그 값이 100% 있음 => 언랩핑
//
//
//    @IBOutlet weak var labelTitle :UILabel!
//    @IBOutlet weak var labelArtist :UILabel!
//    @IBOutlet weak var viewImage :UIImageView!
//
//    // 자신이 관리하는 뷰가 화면에 올라와 있을 때 화면 초기화
//    // 오버라이드 하고 있기 때문에 super를 사용하여 초기화
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let infoMusic = modelMusic.arrayList[modelMusic.selectedIndex]
//
//        // Outlet 으로 받기 때문에 쓰는 시점에는 무조건 값이 있다
//        labelTitle.text = infoMusic.title
//        labelArtist.text = infoMusic.singer
//
//        if let filName = infoMusic.image{
//            viewImage.image = UIImage(named: filName)
//        }
//    }
//
//    @IBAction func touchClose() {
//
//        let 나중에불러줘 = {() -> Void in
//            print("나중에 불렸음~~~~~~~")
//        }
//
//        나중에불러줘()
//
//        self.dismiss(animated: true, completion: 나중에불러줘)
//    }
//}

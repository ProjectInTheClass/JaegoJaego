//
//  StockDetailViewController.swift
//  proc
//
//  Created by swuad_28 on 2018. 8. 2..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit
var stockDetail = StoreDatabase

class StockDetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var save: UIImageView!
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var graimage: UIImageView!
    @IBOutlet weak var totalnum: UILabel!
    @IBOutlet weak var num: UITextField!
    @IBOutlet weak var completebutton: UIButton!
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Completebut(_ sender: Any) {
        let store = stockDetail.arrayList[stockDetail.selectedIndex]
        // proc.Store = (Store)
        //        store.many = store.many - Int(self.num.text!)!
        
        // 해당 재고 수량을 넘어선 개수를 입력하면 숫자가 바뀌지 못하게 막음
        if (store.many - Int(self.num.text!)! <= 0) {
           
            if (store.many - Int(self.num.text!)! == 0) {
                stockDetail.arrayList.remove(at: stockDetail.arrayList.index(of: store)!)
            }
            
            print("가진 재고 수량을 넘었습니다.")
        }
            
//        else if store.many - Int(self.num.text!)! == 0 {
//            stockDetail.arrayList.remove(at: stockDetail.arrayList.index(of: store)!)
//        }
//
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
        
        self.dismiss(animated: true, completion: nil)
        
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
        save.image = UIImage(named: infoStock.saveStyle.rawValue)
        
        //num.text = String(infoStock.many)
        totalnum.text = String(infoStock.TotalMany)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

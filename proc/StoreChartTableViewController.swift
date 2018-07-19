//
//  StoreChartListViewControllerTableViewController.swift
//  proc
//
//  Created by swuad-19 on 2018. 7. 18..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit

struct Store {
    var name: String
    var Date: String
    var many: String
    var Image: String
}


class StoreChartTableViewController: UITableViewController {
    // UITableViewController = UIViewController , UITableViewController (테이블 뷰 관련), UTTableViewDelegate 제공
/**
     재고 목록 동적 테이블 뷰, 배열 사용
 */
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    let StoreChart:[Store] = [
        Store(name:"새우", Date:"2018/07/22", many: "20", Image: "shrimp"),
        Store(name:"레몬", Date:"2018/07/21", many: "5", Image: "lemon"),
        Store(name:"아보카도", Date:"2018/07/22",many: "15", Image: "avocado"),
    ]


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 모델의 데이터 개수와 셀 개수 일치시키기
        return StoreChart.count
    }

   // override func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String? {
   //     return "StoreChart 배열"
   // }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StoreChartCell //tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StoreChartCell
        let store:Store = StoreChart[indexPath.row]

        cell.labelName.text = store.name
        cell.viewImage.image = UIImage(named: store.Image)
        cell.labelDate.text = store.Date
        cell.labelMany.text = store.many
//
//        cell.textLabel!.text = store.name
//        cell.detailTextLabel?.text = String(store.many)
//        cell.imageView?.image = UIImage(named: store.Image)

        return cell
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

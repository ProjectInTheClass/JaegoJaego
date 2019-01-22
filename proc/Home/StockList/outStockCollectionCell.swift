//
//  outStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class outStockCollectionCell: UICollectionViewCell {
    @IBOutlet weak var outStockTV: UITableView!
    var dateCounts : [String] = []

    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
    }
    override func awakeFromNib() {
        dateCounts = StoreDatabase.sellStockArray.map{$0.DownDate}
        print("date counts = \(dateCounts.count)")
    }
}

extension outStockCollectionCell : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateCounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = outStockTV.dequeueReusableCell(withIdentifier: "OutStockDateCell") as! stockListDateCell
            cell.stockDateLabel.text = ""
            return cell
        } else if indexPath.row == 1 {
            let cell = outStockTV.dequeueReusableCell(withIdentifier: "OutStockWriterCell") as! stockListWriterCell
            cell.stockWriterLabel.text = "작성자"
            cell.stockCountLabel.text = "\(StoreDatabase.sellStockArray.count)개 물품"
         
            return cell
        } else {
            let cell = outStockTV.dequeueReusableCell(withIdentifier: "OutStockStockCell") as! stockListStockCell
            cell.stockNameLabel.text = ""
            cell.stockCountLabel.text = ""
            return cell
        }
    }
    
}

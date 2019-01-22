//
//  newStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class newStockCollectionCell: UICollectionViewCell {
    @IBOutlet weak var newStockTV: UITableView!
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
       
    }
}

extension newStockCollectionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreDatabase.buyStockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
                        let cell = newStockTV.dequeueReusableCell(withIdentifier: "NewStockDateCell") as! stockListDateCell
                        cell.stockDateLabel.text = ""
                        return cell
                    } else if indexPath.row == 1 {
                        let cell = newStockTV.dequeueReusableCell(withIdentifier: "NewStockWriterCell") as! stockListWriterCell
                        cell.stockWriterLabel.text = "작성자"
                        cell.stockCountLabel.text = "\(StoreDatabase.buyStockArray.count)개 물품"
            
                        return cell
                    } else {
                        let cell = newStockTV.dequeueReusableCell(withIdentifier: "NewStockStockCell") as! stockListStockCell
                        cell.stockNameLabel.text = ""
                        cell.stockCountLabel.text = ""
                        return cell
        }
    }
    
}

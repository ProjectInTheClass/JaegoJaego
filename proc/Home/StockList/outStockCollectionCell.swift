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
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
    }
    
    override func awakeFromNib() {
        outStockTV.delegate = self
        outStockTV.dataSource = self
    }
}

extension outStockCollectionCell : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return StoreDatabase.sellStockArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = outStockTV.dequeueReusableCell(withIdentifier: "OutStockCell") as! outStockCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 45
        case 1:
            return 60
        default :
            return 35
        }
    }
}

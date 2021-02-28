//
//  stockCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 23..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class StockSubTitleTableCell: UITableViewCell {
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var stockCountLabel: UILabel!

    static let subTitleTableCellID = "stockSubTitleTableCell"
    
    func bindViewModel(stockName: String, stockCount: Int, stockType: String){
        stockNameLabel.text = stockName
        stockCountLabel.text = "\(stockCount)\(stockType)"
    }
}

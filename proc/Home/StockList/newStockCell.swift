//
//  newStockCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 23..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

var counts = 0

class newStockCell: UITableViewCell {
    @IBOutlet weak var newDateLabel: UILabel!
    @IBOutlet weak var newCountLabel: UILabel!
    @IBOutlet weak var newWriterLabel: UILabel!
    @IBOutlet weak var newListTV: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newListTV.delegate = self
        newListTV.dataSource = self
    }

    func stringToDate(value:String) -> Date{
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy.MM.dd"
        return dateFormmater.date(from: value)!
    }
}

extension newStockCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datePerStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newListTV.dequeueReusableCell(withIdentifier: "NewStockListCell") as! stockListCell
        counts += indexPath.row
        let state = StoreDatabase.buyStockArray[indexPath.row]
//        let state = StoreDatabase.buyStockArray.filter{ $0.UpDate == stringToDate(value: newDateLabel.text!) }
    
        cell.stockNameLabel.text = state.name
        cell.stockCountLabel.text = "\(state.many)"
        
        return cell
    }
}

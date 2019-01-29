//
//  newStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

var datePerStock : [Store] = []

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
    
    override func awakeFromNib() {
        newStockTV.delegate = self
        newStockTV.dataSource = self
        
        
    }
}

extension newStockCollectionCell : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 날짜 개수에 따른 값
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StoreDatabase.newDatePerCountDic.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newStockTV.dequeueReusableCell(withIdentifier: "NewStockCell" , for: indexPath) as! newStockCell
        let state = StoreDatabase.buyStockArray[indexPath.row]
        
        cell.newWriterLabel.text = "작성자"
        cell.newDateLabel.text = dateToString(state.UpDate)
        cell.newCountLabel.text = "\(state.many)"
        
        datePerStock = StoreDatabase.getNewDatePerStock(date: state.UpDate)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
}

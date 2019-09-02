//
//  newStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

struct Objects {
    var sectionDate : Date!
    var sectionStock : [Store]!
}

class newStockCollectionCell: UICollectionViewCell {
    @IBOutlet weak var newStockTV: UITableView!
    
    var objectArray_Main = [Objects]()
    
    override func awakeFromNib() {
        newStockTV.delegate = self
        newStockTV.dataSource = self
        setSubLayer()
        
        for (key, value) in StoreDatabase.stockListPerDate {
            objectArray_Main.append(Objects(sectionDate: key, sectionStock: value))
        }
        objectArray_Main.sort(by: {$0.sectionDate > $1.sectionDate})
        
        newStockTV.reloadData()
    }
}


extension newStockCollectionCell : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray_Main.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray_Main[section].sectionStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = objectArray_Main[indexPath.section].sectionStock[indexPath.row]
        let cell = newStockTV.dequeueReusableCell(withIdentifier: "NewStockNameManyCell", for: indexPath) as! newStockNameManyCell
            
        cell.stockNameLabel.text = state.name
        cell.stockCountLabel.text = "\(state.many)\(state.manytype)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "NewStockCell") as! newStockCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        var many = 0
        for i in objectArray_Main[section].sectionStock{
            many += i.many
        }
        
        headerCell.newDateLabel.text = dateFormatter.string(from:  objectArray_Main[section].sectionDate)
        headerCell.newCountLabel.text = "총 \(many)개"
        
        return headerCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
}

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
    
    var objectArray = [outObjects]()
    
    struct outObjects {
        var sectionDate : Date!
        var sectionStock : [Store]!
    }
    
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
        
        for (key, value) in StoreDatabase.outStockListPerDate {
            objectArray.append(outObjects(sectionDate: key, sectionStock: value))
        }
        objectArray.sort(by: {$0.sectionDate > $1.sectionDate})
    }
}

extension outStockCollectionCell : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return objectArray[section].sectionStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = objectArray[indexPath.section].sectionStock[indexPath.row]
        let cell = outStockTV.dequeueReusableCell(withIdentifier: "OutStockNameManyCell", for: indexPath) as! outStockNameManyCell
        
        cell.outStockNameLabel.text = state.name
        cell.outStockCountLabel.text = "\(state.many)\(state.manytype)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "OutStockCell") as! outStockCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        var many = 0
        for i in objectArray[section].sectionStock{
            many += i.many
        }
        
        headerCell.outStockDateLabel.text = dateFormatter.string(from:  objectArray[section].sectionDate)
        headerCell.outStockManyLabel.text = "총 \(many)개 제품"
        
        return headerCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
}

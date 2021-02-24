//
//  newStockCollectionCell.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

struct SectionObjects {
    var sectionDate : Date!
    var sectionStock : [Store]!
}

class newStockCollectionCell: UICollectionViewCell {
    @IBOutlet weak var newStockTV: UITableView!
    
    private let viewModel = StoreViewModel()
    private var sectionArray : [SectionObjects] = []
    
    override func awakeFromNib() {
        setSubViews()
    }
    
    private func setSubViews(){
        newStockTV.delegate = self
        newStockTV.dataSource = self
        setSubLayer()
        
        for (key, value) in viewModel.returnStockPerDateBuyArray() {
            sectionArray.append(SectionObjects(sectionDate: key, sectionStock: value))
        }
        sectionArray.sort(by: {$0.sectionDate > $1.sectionDate})
        newStockTV.reloadData()
    }
}


extension newStockCollectionCell : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionArray[section].sectionStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = sectionArray[indexPath.section].sectionStock[indexPath.row]
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
        for i in sectionArray[section].sectionStock {
            many += i.many
        }
        
        headerCell.newDateLabel.text = dateFormatter.string(from:  sectionArray[section].sectionDate)
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

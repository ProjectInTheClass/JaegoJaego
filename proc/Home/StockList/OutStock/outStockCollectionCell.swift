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
    
    private var viewModel = StoreViewModel()
    private var sectionArray : [SectionObjects] = []
    
    override func awakeFromNib() {
        setSubViews()
    }
    
    private func setSubViews(){
        outStockTV.delegate = self
        outStockTV.dataSource = self
        setSubLayer()
        
        for (key, value) in viewModel.returnStockPerDateOutArray() {
            sectionArray.append(SectionObjects(sectionDate: key, sectionStock: value))
        }
        
        sectionArray.sort(by: {$0.sectionDate > $1.sectionDate})
        outStockTV.reloadData()
    }
}

extension outStockCollectionCell : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return sectionArray[section].sectionStock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let state = sectionArray[indexPath.section].sectionStock[indexPath.row]
        let cell = outStockTV.dequeueReusableCell(withIdentifier: "OutStockNameManyCell", for: indexPath) as! outStockNameManyCell
        
        cell.outStockNameLabel.text = state.name
        cell.outStockCountLabel.text = "\(state.many)\(state.manytype)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "OutStockCell") as! outStockCell

        var many = 0
        
        for i in sectionArray[section].sectionStock{
            many += i.many
        }
        
        headerCell.outStockDateLabel.text = sectionArray[section].sectionDate.returnString(format: "yyyy. MM. dd")
        headerCell.outStockManyLabel.text = "총 \(many)개"
        
        return headerCell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
}

//
//  StockListVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 22..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit

class StockListVC: UIViewController {
    @IBOutlet weak var stockCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCollectionDelegate()
    }
}

extension StockListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func getCollectionDelegate(){
        stockCollectionView.delegate = self
        stockCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var state = indexPath.row % 3
        switch state {
        case 0:
            return staticCollectionSetting(stockCollectionView, indexpath: indexPath)
        case 1:
            return newCollectionSetting(stockCollectionView, indexpath: indexPath)
        default:
           return  outCollectionSetting(stockCollectionView, indexpath: indexPath)
        }
    }
    
    // 입고 목록 세팅
    func newCollectionSetting(_ collectionView : UICollectionView, indexpath:IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCollectionCell", for: indexpath) as! newStockCollectionCell
        return cell
    }
    
    // 출고 목록 세팅
    func outCollectionSetting(_ collectionView: UICollectionView, indexpath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutCollectionCell", for: indexpath) as! outStockCollectionCell
        return cell
    }
    
    // 미정 - 통계 목록 세팅
    func staticCollectionSetting(_ collectionView: UICollectionView, indexpath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StaticCollectionCell", for: indexpath) as! staticStockCollectionCell
        return cell
    }
    
}

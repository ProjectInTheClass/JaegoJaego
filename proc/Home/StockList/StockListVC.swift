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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.stockCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCollectionDelegate()
    }
    
    
    func getCollectionDelegate(){
        stockCollectionView.delegate = self
        stockCollectionView.dataSource = self
        stockCollectionView.showsHorizontalScrollIndicator = false
    }
}


extension StockListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return indexPath.row % 2 == 0 ?
            newCollectionSetting(stockCollectionView, indexpath: indexPath) :
            outCollectionSetting(stockCollectionView, indexpath: indexPath)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
//    // 미정 - 통계 목록 세팅
//    func staticCollectionSetting(_ collectionView: UICollectionView, indexpath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StaticCollectionCell", for: indexpath) as! staticStockCollectionCell
//        return cell
//    }
    
    
//    // 초점 가운데로 모이게 하기
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.stockCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWithIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWithIncludingSpacing
//        let roundedIndex = round(index)
//
//        let settingFocus = (self.view.frame.width - layout.itemSize.width ) / 2
//
//        offset = CGPoint(x: roundedIndex * cellWithIncludingSpacing - scrollView.contentInset.left - settingFocus, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }
}


extension StockListVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - (15 * 2)
        let height = self.view.frame.height - (75 * 2)
        return CGSize(width: width, height: height)
    }
}

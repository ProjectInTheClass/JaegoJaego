//
//  StoreVC.swift
//  proc
//
//  Created by 성다연 on 2019. 1. 21..
//  Copyright © 2019년 swuad-19. All rights reserved.
//

import UIKit
import Foundation

class StoreVC: UIViewController , UISearchBarDelegate {
    @IBOutlet weak var storeListTV: UITableView!
    @IBOutlet weak var storeSearchBar: UISearchBar!
    @IBOutlet weak var searchListView: UIView!
    
    // 세그먼트 변수
    let segmentColor = UIColor(red: 0.26, green: 0.43, blue: 0.85, alpha: 1.0)
    let segmentFont = "DiwanMishafi"
    var buttonBar = UIView()
    var switchSegment = UISegmentedControl()
    var selectSegmentNumber = 0
    
    // 재고 변수
    var array00Trash : [Store] = []
    var array01Today : [Store] = []
    var array02Safe : [Store] = []
    // 검색 필터
    var searchFilterData0 : [Store] = []
    var searchFilterData1 : [Store] = []
    var searchFilterData2 : [Store] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeListTV.delegate = self
        storeListTV.dataSource = self
        storeSearchBar.placeholder = "재고 이름을 검색하세요."
        storeSearchBar.delegate = self
        StoreDatabase.sameStoreMany()
        
        segmentSetting()
        buttonbarSetting()
        upDateArraysFromModel()
        storeListTV.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchFilterData0 = array00Trash.sorted(by: {$0.DownDate < $1.DownDate })
        searchFilterData1 = array01Today.sorted(by: {$0.DownDate < $1.DownDate})
        searchFilterData2 = array02Safe.sorted(by: {$0.DownDate < $1.DownDate})
        
        self.storeListTV.reloadData()
    }
}


// 함수
extension StoreVC {
    func upDateArraysFromModel(){
        array00Trash = StoreDatabase.storesUntilDate(fromDays: -1, toDays: 0)
        array01Today = StoreDatabase.storesUntilDate(fromDays: 0, toDays: 1)
        array02Safe = StoreDatabase.storesUntilDate(fromDays: 2, toDays: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFilterData0 = searchText.isEmpty ? array00Trash : array00Trash.filter{ $0.name.range(of: searchText) != nil}
        searchFilterData1 = searchText.isEmpty ? array01Today : array01Today.filter{ $0.name.range(of: searchText) != nil}
        searchFilterData2 = searchText.isEmpty ? array02Safe : array02Safe.filter{ $0.name.range(of: searchText) != nil}
        
        storeListTV.reloadData()
    }
    
    // 취소버튼 클릭 시 키보드 닫히고 검색어 초기화
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        storeSearchBar.text = ""
        storeSearchBar.resignFirstResponder()
        self.storeListTV.reloadData()
    }
}


// 테이블 뷰
extension StoreVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rValue = 0
        switch selectSegmentNumber {
            case 0:
                rValue = self.searchFilterData0.count
            case 1:
                rValue = self.searchFilterData1.count
            default:
                rValue = self.searchFilterData2.count
        }
        return rValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var arrayStore : [Store]!
        
        switch selectSegmentNumber {
        case 0:
            arrayStore = searchFilterData0
        case 1:
            arrayStore = searchFilterData1
        default:
            arrayStore = searchFilterData2
        }
        
        let store = arrayStore[indexPath.row]
        let cell:StoreChartCell_More = tableView.dequeueReusableCell(withIdentifier: "Cell2IngredientBig") as! StoreChartCell_More
        
        // cell
        cell.labelName.text = store.name
        cell.labelSaveStyle.image = UIImage(named: store.saveStyle.rawValue)
        cell.labelDownDate.text = store.DownDate
        cell.labelMany.text = String(store.many) + String(store.manytype)
        //proccell.labelManyType.text = String(store.manytype)
        cell.labelTotalMany.text = String(store.TotalMany) + String(store.manytype)
        
        
        if let image2 = store.Image {
            cell.ChartImage.image = UIImage(named: image2)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}



// 세그먼트
extension StoreVC {
    
    /** 세그먼트 바 설정 */
    func segmentSetting(){
        switchSegment.insertSegment(withTitle: "폐기 물품", at: 0, animated: true)
        switchSegment.insertSegment(withTitle: "당일 마감", at: 1, animated: true)
        switchSegment.insertSegment(withTitle: "양호 물품", at: 2, animated: true)
        switchSegment.selectedSegmentIndex = 0
        switchSegment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchSegment)
        
        switchSegment.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 8).isActive = true
        
        switchSegment.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        switchSegment.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        switchSegment.backgroundColor = .clear
        switchSegment.tintColor = .clear
        switchSegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: segmentFont, size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        switchSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: segmentFont,size : 18),
                                              NSAttributedString.Key.foregroundColor: segmentColor],  for: .selected)
        
        switchSegment.addTarget(self, action: #selector(StoreVC.segmentControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        buttonbarSetting()
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl){
        UIView.animate(withDuration: 0.3){
            self.buttonBar.frame.origin.x = (self.switchSegment.frame.width / CGFloat(self.switchSegment.numberOfSegments)) * CGFloat(self.switchSegment.selectedSegmentIndex)
        }
        
        if(switchSegment.selectedSegmentIndex == 0) {
            UIView.animate(withDuration: 0.3, animations: {
                self.selectSegmentNumber = 0
            })
        }
        else if (switchSegment.selectedSegmentIndex == 1){
            UIView.animate(withDuration: 0.3, animations: {
                self.selectSegmentNumber = 1
            })
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {
                self.selectSegmentNumber = 2
            })
        }
        self.storeListTV.reloadData()
    }
    
    /** 세그먼트 하단 바 설정 */
    func buttonbarSetting(){
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = segmentColor
        view.addSubview(buttonBar)
        
        buttonBar.topAnchor.constraint(equalTo: switchSegment.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: switchSegment.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: switchSegment.widthAnchor, multiplier: 1 / CGFloat(switchSegment.numberOfSegments)).isActive = true
    }
}

//
//  StoreSearchTableViewController.swift
//  proc
//
//  Created by 이유진 on 2018. 7. 28..
//  Copyright © 2018년 swuad-19. All rights reserved.
//

import UIKit

class StoreSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var modelStore = StoreDatabase
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (modelStore.arrayList as NSArray).filtered(using: searchPredicate)
        //let array = (modelStore.name_array as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int { //사용되고 있는 셀의 개수
        // 1
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 2
        if (self.resultSearchController.isActive) {
            return self.filteredTableData.count
        }
        else {
            return self.modelStore.arrayList.count
            //return self.modelStore.name_array.count
        }
    }
    
    //테이블뷰 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //modelStore.name_array.remove(at: indexPath.row)
        modelStore.arrayList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        print("modelstore = \(modelStore.arrayList)")
        print("stockbase = \(StoreDatabase.arrayList)")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let SearchCell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath as IndexPath)
        
        // 3
        if (self.resultSearchController.isActive) {
            SearchCell.textLabel?.text = filteredTableData[indexPath.row]
            
            return SearchCell
        }
        else {
            //SearchCell.textLabel?.text = modelStore.name_array[indexPath.row]
            SearchCell.textLabel?.text = modelStore.arrayList[indexPath.row].name
            return SearchCell
        }
    }
    
}

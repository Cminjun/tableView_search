//
//  ViewController.swift
//  DEUSearch
//
//  Created by D7703_14 on 2017. 11. 15..
//  Copyright © 2017년 minjun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    
    var twiceDic:[String:[String]]!
    var twiceNames:[String]!
    var searchCon: UISearchController!
    var filteredArr = [String]()
    
    @IBOutlet var minTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonPath = Bundle.main.path(forResource: "Twice", ofType: "json")
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonPath!))
        self.twiceDic = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:[String]]
        self.twiceNames = Array(self.twiceDic.keys)
        
        self.searchCon = {
            
            let con = UISearchController(searchResultsController: nil)
            
            con.searchResultsUpdater = self
            con.dimsBackgroundDuringPresentation = false
            con.searchBar.sizeToFit()
            minTableView.tableHeaderView = con.searchBar
            
            return con
        }()
        
        
        self.minTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Reuse")
        
        minTableView.delegate = self
        minTableView.dataSource = self
        
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredArr.removeAll(keepingCapacity: false)
        let predicateA = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let arrayF = (twiceNames as NSArray).filtered(using: predicateA)
        filteredArr = arrayF as! [String]
        self.minTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCon.isActive ? self.filteredArr.count : twiceNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse", for: indexPath)
        
        
        cell.textLabel?.text = searchCon.isActive ? filteredArr[indexPath.row] : twiceNames[indexPath.row]
        
        
        return cell
    }
    

}


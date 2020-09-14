//
//  TaskTableViewController.swift
//  SwiftSearch
//
//  Created by DiRai on 14/09/20.
//  Copyright © 2020 DiRai. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController, UISearchBarDelegate {

    let taskArray = [
        "15 Minutes Workout",
        "Wash Dishes",
        "Pick Up Kids At 3","Water The Plants",
        "New Images For Blog",
        "Make Lunch",
        "10000 Steps",
        "Make Bed",
        "Call Mom",
        "Buy Halloween Costume",
        "Drink Water",
        "New Instagram Post",
        "Bake Cookies" ]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredTask = [String]()
    
    var isSearchBarEmpty : Bool {
        return searchController.searchBar.text!.isEmpty
    }
    
    var isFiltering : Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Task"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filteredTask.count
        }
        return taskArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let task : String
        if isFiltering{
            task = filteredTask[ indexPath.row ]
        }else{
            task = taskArray[ indexPath.row ]
        }
        cell.textLabel!.text = task
        return cell
    }
    
    
    // Helper Functions
    
    func filterContentForSearchText(_ searchText : String, category : String? = nil){
        filteredTask = taskArray.filter{
            return $0.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

}

extension TaskTableViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

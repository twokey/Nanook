//
//  DestinationLookUpTableViewController.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-27.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class DestinationLookUpTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties
    
    var destinations = [Destination]()
    var filteredDestinations = [Destination]()
    let searchController = UISearchController(searchResultsController: nil)
    let rome2RioClient = Rome2RioClient()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var destinationTableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.definesPresentationContext = true
        
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"]
        searchContainerView.addSubview(searchController.searchBar)
//        let attributes: [NSLayoutAttribute] = [.top, .bottom, . left, .right]
//        NSLayoutConstraint.activate(attributes.map{NSLayoutConstraint(item: self.searchController.searchBar, attribute: $0, relatedBy: .equal, toItem: self.searchContainerView, attribute: $0, multiplier: 1, constant: 0)})
    
        destinations = [
            Destination(category:"Chocolate", name:"Chocolate Bar"),
            Destination(category:"Chocolate", name:"Chocolate Chip"),
            Destination(category:"Chocolate", name:"Dark Chocolate"),
            Destination(category:"Hard", name:"Lollipop"),
            Destination(category:"Hard", name:"Destination Cane"),
            Destination(category:"Hard", name:"Jaw Breaker"),
            Destination(category:"Other", name:"Caramel"),
            Destination(category:"Other", name:"Sour Chew"),
            Destination(category:"Other", name:"Gummi Bear")
        ]
    
        rome2RioClient.getPlacesFor("Lon") { (places, error) in
            print(places)
        }
    }

    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredDestinations.count
        }
        
        return destinations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath)

        // Prepare data
        let destination: Destination
        if searchController.isActive && searchController.searchBar.text != "" {
            destination = filteredDestinations[indexPath.row]
        } else {
            destination = destinations[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel?.text = destination.name
        cell.detailTextLabel?.text = destination.category

        return cell
    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredDestinations = destinations.filter{ destination in
            
            return destination.name.lowercased().contains(searchText.lowercased())
        }
        
        destinationTableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DestinationLookUpTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

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
    
    var destinations = [Place]()
    let rome2RioClient = Rome2RioClient()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var destinationTableView: UITableView!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return destinations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath)

        // Prepare data
        let destination = destinations[indexPath.row]
        
        // Configure the cell
        cell.textLabel?.text = destination.longName
        cell.detailTextLabel?.text = destination.countryName

        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DestinationLookUpTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        destinations.removeAll()
        
        // TODO: Add delay to not overload API
        rome2RioClient.getPlacesFor(searchText) { (places, error) in
            
            self.destinations.append(contentsOf: places!)
            DispatchQueue.main.async {
                self.destinationTableView.reloadData()
            }
        }
    }
    
}

//
//  OriginLookUpTableViewController.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-11.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class OriginLookUpTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Properties
    
    let rome2RioClient = Rome2RioClient()
    var origins = [Place]()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var originTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return origins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "originCell", for: indexPath)
        
        // Prepare data
        let origin = origins[indexPath.row]
        
        // Configure the cell
        cell.textLabel?.text = origin.longName
        cell.detailTextLabel?.text = origin.countryName
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let destinationLookUpTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "destinationLookUpTableViewController") as! DestinationLookUpTableViewController
        
        destinationLookUpTableViewController.origin = origins[indexPath.row]
        
        self.navigationController?.pushViewController(destinationLookUpTableViewController, animated: true)

    }
    
    
    // MARK: - Actions
    
    @IBAction func viewSummary(_ sender: UIBarButtonItem) {
        
        let routeSummaryTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "savedRoutesTableViewController") as! RouteSummaryTableViewController

        searchBar.text = ""
        origins.removeAll()
        originTableView.reloadData()
        
        self.navigationController?.pushViewController(routeSummaryTableViewController, animated: true)

    }
}


// MARK: - UISearchBarDelegate

extension OriginLookUpTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        origins.removeAll()
        
        if searchText.characters.count >= 2 {
            rome2RioClient.getPlacesFor(searchText) { (places, error) in
                
                self.origins.append(contentsOf: places!)
                DispatchQueue.main.async {
                    self.originTableView.reloadData()
                }
            }
        }
    }
}

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
    
    var origin: Place!
    var destinations = [Place]()
    let rome2RioClient = Rome2RioClient()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var destinationTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var originLabel: UILabel!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        originLabel.text = origin.longName
    }

    
    // MARK: - UITableViewDataSource

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
    
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let routeOptionsTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "routesOptionsViewController") as! RouteOptionsTableViewController
        
        routeOptionsTableViewController.destinationPlace = destinations[indexPath.row]
        routeOptionsTableViewController.originPlace = origin

        searchBar.text = ""
        destinations.removeAll()
        destinationTableView.reloadData()
        
        self.navigationController?.pushViewController(routeOptionsTableViewController, animated: true)
    }
}


// MARK: - SearchBarDelegate

extension DestinationLookUpTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        destinations.removeAll()
        
        if searchText.characters.count >= 2 {
            rome2RioClient.getPlacesFor(searchText) { (places, error) in
                
                guard error == nil else {
                    DispatchQueue.main.async {
                        AllertViewController.showAlertWithTitle("Connection", message: "Connection has been lost. Please try again.")
                    }
                    return
                        
                }
                
                if let places = places {
                    self.destinations.append(contentsOf: places)
                    DispatchQueue.main.async {
                        self.destinationTableView.reloadData()
                    }
                } else {
                    AllertViewController.showAlertWithTitle("Request Result", message: "No search results were reseived. Please try again")
                }
            }
        }
    }
    
}

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
    var destinationsChosen = [Place]()
    var destinations = [Place]()
    let rome2RioClient = Rome2RioClient()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var destinationTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var destinationLabel1: UILabel!
    @IBOutlet weak var destinationLabel2: UILabel!
    @IBOutlet weak var destinationLabel3: UILabel!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        originLabel.text = origin.longName
        updateLabelsFor(chosenDestinations: destinationsChosen)
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
    
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if destinationsChosen.count < 3 {
            destinationsChosen.append(destinations[indexPath.row])
            updateLabelsFor(chosenDestinations: destinationsChosen)
        }
        
        searchBar.text = ""
        destinations.removeAll()
        destinationTableView.reloadData()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let routeOptionsPageViewController = segue.destination as! RouteOptionsPageViewController
        routeOptionsPageViewController.destinations = destinationsChosen
        routeOptionsPageViewController.origin = origin
        
    }
    
    
    // MARK: Helpers
    
    func updateLabelsFor(chosenDestinations: [Place]) {

        switch chosenDestinations.count {
        case 1:
            destinationLabel1.text = chosenDestinations[0].longName
            destinationLabel2.text = ""
            destinationLabel3.text = ""
        case 2:
            destinationLabel1.text = chosenDestinations[0].longName
            destinationLabel2.text = chosenDestinations[1].longName
            destinationLabel3.text = ""
        case 3:
            destinationLabel1.text = chosenDestinations[0].longName
            destinationLabel2.text = chosenDestinations[1].longName
            destinationLabel3.text = chosenDestinations[2].longName
        default:
            destinationLabel1.text = ""
            destinationLabel2.text = ""
            destinationLabel3.text = ""

        }
    }
}

extension DestinationLookUpTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        destinations.removeAll()
        
        // TODO: Add delay to not overload API
        if searchText.characters.count >= 2 {
            rome2RioClient.getPlacesFor(searchText) { (places, error) in
                
                self.destinations.append(contentsOf: places!)
                DispatchQueue.main.async {
                    self.destinationTableView.reloadData()
                }
            }
        }
    }
    
}

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
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Table view data source
    
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
    
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let destinationLookUpTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "destinationLookUpTableViewController") as! DestinationLookUpTableViewController
        
        destinationLookUpTableViewController.origin = origins[indexPath.row]
        
        self.navigationController?.pushViewController(destinationLookUpTableViewController, animated: true)

    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
//        if segue.destinationViewController == "destinationLookUpTableViewController" {
//            
//        }
        
    }
}

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

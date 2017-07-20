//
//  RouteSummaryTableViewController.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-19.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RouteSummaryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    // MARK: Properties

    let context = CoreDataManager.sharedInstance.mainManagedObjectContext

    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<RouteSummary> = {
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<RouteSummary> = RouteSummary.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = []
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        // Start the Fetched Results Controller
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error performing initial fetch: \(error)")
        }
        
        return fetchedResultsController

    }()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var routeSummaryTableView: UITableView!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error performing initial fetch: \(error)")
        }
        routeSummaryTableView.reloadData()
    }
    
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airLegCell", for: indexPath) as! AirLegSummaryTableViewCell
        
        // Prepare data
        let cellInfo = fetchedResultsController.object(at: indexPath) 
        let routeGraphImage = UIImage(data: cellInfo.routeGraph! as Data)
        
        // Configure the cell
        
        cell.origin.text = cellInfo.origin
        cell.destination.text = cellInfo.destination
        cell.operatingDays.text = cellInfo.operatingDays
        cell.departureTime.text = cellInfo.departureTime
        cell.arrivalTime.text = cellInfo.arrivalTime
        cell.travelTime.text = cellInfo.travelTime
        cell.price.text = cellInfo.price
        cell.routeGraph.image = routeGraphImage

        
        return cell
    }

}

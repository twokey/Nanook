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

    var selectedRow: IndexPath?
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
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteButton.isEnabled = false
        
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
    
    
    // MARK: TableViewDelegate
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (tableView.cellForRow(at: indexPath)?.isSelected)! {
            deleteButton.isEnabled = false
            selectedRow = nil
            tableView.cellForRow(at: indexPath)?.isSelected = false
            return nil
        } else {
            return indexPath
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deleteButton.isEnabled = true
        selectedRow = indexPath
    }
    
    
    // MARK: Actions
    
    @IBAction func deleteRoute(_ sender: UIBarButtonItem) {
        if let indexPath = selectedRow {

            let routeToDelete = fetchedResultsController.object(at: indexPath)
            context.delete(routeToDelete)
            CoreDataManager.sharedInstance.saveChanges()
            
            do {
                try fetchedResultsController.performFetch()
            } catch let error as NSError {
                print("Error performing initial fetch: \(error)")
            }
            routeSummaryTableView.reloadData()
        }
    }
}

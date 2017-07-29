//
//  RouteOptionsTableViewController.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit
import CoreData

class RouteOptionsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties
    
    let rome2RioClient = Rome2RioClient()
    var searchResult = RoutesSearchResponse()
    var originPlace: Place!
    var destinationPlace: Place!
    
    
    // MARK: Outlets
    
    @IBOutlet weak var routesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "Available options"
        saveButton.isEnabled = false
        
        // Exclude all surface segments
        let options = [Constants.Rome2RioSearchParameters.noRail : "true",
                       Constants.Rome2RioSearchParameters.noBus : "true",
                       Constants.Rome2RioSearchParameters.noFerry : "true",
                       Constants.Rome2RioSearchParameters.noCar : "true",
                       Constants.Rome2RioSearchParameters.noBikeshare : "true",
                       Constants.Rome2RioSearchParameters.noRideshare : "true",
                       Constants.Rome2RioSearchParameters.noTowncar : "true",
                       Constants.Rome2RioSearchParameters.noCommuter : "true",
                       Constants.Rome2RioSearchParameters.noSpecial : "true",
                       ] as [String:AnyObject]
        
        rome2RioClient.getRoutes(from: originPlace.shortName, to: destinationPlace.shortName, options: options) { (searchResult, error) in
            
            // Was there an error during request?
            guard (error == nil) else {
                print(error!)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    AllertViewController.showAlertWithTitle("Connection", message: "Connection has been lost. Please try again.")
                }
                return
            }
            
            guard let searchResult = searchResult else {
                print("Search results cannot be unwrapped")
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    AllertViewController.showAlertWithTitle("Request Result", message: "No search results were reseived. Please try again")
                }
                return
            }

            guard let _ = searchResult.airSegment() else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    AllertViewController.showAlertWithTitle("Request Result", message: "No search results were reseived. Please try again")
                }
                return
            }

            self.searchResult = searchResult
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.routesTableView.reloadData()
            }
        }
    }

    
    // MARK: - TableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let airSegment = searchResult.airSegment() {
            return airSegment.outbound.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airLegCell", for: indexPath) as! AirLegTableViewCell

        // Prepare data

        guard let airSegment = searchResult.airSegment() else {
            return cell
        }
        let airLeg = airSegment.outbound[indexPath.row] as AirLeg
        
        // Configure the cell
        
        let firstHop = airLeg.hops.first
        let lastHop = airLeg.hops.last
        
        let price: String
        if let indicativePrices = airLeg.indicativePrices {
            let priceLow = String(indicativePrices.priceLow ?? 0.0)
            let priceHigh = String(indicativePrices.priceHigh ?? 0.0)
            price = indicativePrices.currency + " " + priceLow + " - " + priceHigh
        } else {
            price = "Not provided"
        }
        
        cell.origin.text = originPlace.shortName
        cell.destination.text = destinationPlace.shortName
        cell.operatingDays.text = airLeg.operatingDaysString()
        cell.departureTime.text = firstHop?.depTime
        cell.arrivalTime.text = lastHop?.arrTime
        cell.travelTime.text = airLeg.durationString()
        cell.price.text = price
        cell.routeGraph.airLeg = airLeg
        cell.routeGraph.layoutSubviews()

        return cell
    }
    

    // MARK: TableViewDelegate
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (tableView.cellForRow(at: indexPath)?.isSelected)! {
            saveButton.isEnabled = false
            tableView.cellForRow(at: indexPath)?.isSelected = false
            return nil
        } else {
            return indexPath
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveButton.isEnabled = true
    }
    
    
    // MARK: Actions
    
    @IBAction func saveRoute(_ sender: UIBarButtonItem) {
        
        
        
        if let indexPath = routesTableView.indexPathForSelectedRow {
            
            // Prepare data
            guard let airSegment = searchResult.airSegment() else {
                return
            }
            
            let airLeg = airSegment.outbound[indexPath.row] as AirLeg
            
            let firstHop = airLeg.hops.first
            let lastHop = airLeg.hops.last
            
            let price: String
            if let indicativePrices = airLeg.indicativePrices {
                let priceLow = String(indicativePrices.priceLow ?? 0.0)
                let priceHigh = String(indicativePrices.priceHigh ?? 0.0)
                price = indicativePrices.currency + " " + priceLow + " - " + priceHigh
            } else {
                price = "Not provided"
            }

            let cell = routesTableView.cellForRow(at: indexPath) as! AirLegTableViewCell
            let graphView = cell.routeGraph!
            
            UIGraphicsBeginImageContextWithOptions(graphView.bounds.size, graphView.isOpaque, 0.0)
            graphView.drawHierarchy(in: graphView.bounds, afterScreenUpdates: false)
            let snapshotImageFromView = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            let dataForSnapshotImage = UIImagePNGRepresentation(snapshotImageFromView!) as NSData?
       
            let context = CoreDataManager.sharedInstance.mainManagedObjectContext
            
            let fetchRequest: NSFetchRequest<RouteSummary> = RouteSummary.fetchRequest()
            let parameterArray = [self.originPlace.shortName, self.destinationPlace.shortName, airLeg.durationString()]
            fetchRequest.predicate = NSPredicate(format: "origin = %@ AND destination = %@ AND travelTime = %@", argumentArray: parameterArray)
            
            do {
                let savedRoute = try context.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
                
                // we shouldn't have any duplicates in Core Data
                if savedRoute.count == 0 {
                    // Save the data
                    
                    let route = RouteSummary(context: context)
                    route.origin = originPlace.shortName
                    route.destination = destinationPlace.shortName
                    route.departureTime = firstHop?.depTime
                    route.arrivalTime = lastHop?.arrTime
                    route.operatingDays = airLeg.operatingDaysString()
                    route.travelTime = airLeg.durationString()
                    route.price = price
                    route.routeGraph = dataForSnapshotImage
                    CoreDataManager.sharedInstance.saveChanges()
                    AllertViewController.showAlertWithTitle("Saved Routes", message: "The route has been saved")
                } else {
                    AllertViewController.showAlertWithTitle("Saved Routes", message: "This route has been saved before")
                }
                
            } catch {
                AllertViewController.showAlertWithTitle("Memory", message: "Cannot get access to device's memory")
            }

        } else {
            AllertViewController.showAlertWithTitle("Routes", message: "No row has been selected")
        }
    }
}

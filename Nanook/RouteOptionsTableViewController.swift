//
//  RouteOptionsTableViewController.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class RouteOptionsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties
    
    let rome2RioClient = Rome2RioClient()
    let coreDataManager = CoreDataManager(modelName: "Nanook")
    var searchResult = RoutesSearchResponse()
    var originPlace: Place!
    var destinationPlace: Place!
//    var destinationIndex: Int!
    
    
    // MARK: Outlets
    
    @IBOutlet weak var routesTableView: UITableView!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
  //      coreDataManager.dropAllData()
        
        
        self.navigationController?.title = "Available options"
        
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
                return
            }
            
            guard let searchResult = searchResult else {
                print("Search results cannot be unwrapped")
                return
            }
            
            self.searchResult = searchResult
            
            DispatchQueue.main.async {
                self.routesTableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

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
       
            // Save the data
            let context = coreDataManager.mainManagedObjectContext


            let route = RouteSummary(context: context)
            route.origin = originPlace.shortName
            route.destination = destinationPlace.shortName            
            route.departureTime = firstHop?.depTime
            route.arrivalTime = lastHop?.arrTime
            route.operatingDays = airLeg.operatingDaysString()
            route.travelTime = airLeg.durationString()
            route.price = price
            route.routeGraph = dataForSnapshotImage
            coreDataManager.saveChanges()
            
        } else {
            print("No row has been selected")
        }
        
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

    //MARK: - Navigation
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        let routeSummaryTableViewController = segue.destination as! RouteSummaryTableViewController
        routeSummaryTableViewController.coreDataManager = self.coreDataManager
    }
}

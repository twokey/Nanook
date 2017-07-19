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
    var searchResult = RoutesSearchResponse()
    var originPlace: Place!
    var destinationPlace: Place!
//    var destinationIndex: Int!
    
    
    // MARK: Outlets
    
    @IBOutlet weak var routesTableView: UITableView!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = destinationPlace.shortName
        
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
        
        let departureTime = firstHop?.depTime
        let arrivalTime = lastHop?.arrTime
        let price: String
        if let indicativePrices = airLeg.indicativePrices {
            price = indicativePrices.currency + " " + String(describing: indicativePrices.priceLow) + " - " + String(describing: indicativePrices.priceHigh)
        } else {
            price = "Not provided"
        }
        
        cell.operatingDays.text = airLeg.operatingDaysString()
        cell.departureTime.text = departureTime
        cell.arrivalTime.text = arrivalTime
        cell.travelTime.text = airLeg.durationString()
        cell.price.text = price
        
        cell.routeGraph.airLeg = airLeg
        cell.routeGraph.layoutSubviews()

        return cell
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

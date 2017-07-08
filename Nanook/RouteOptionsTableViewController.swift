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
    let origin = "Vancouver"
    let destination = "Yekaterinburg"
    var searchResult = RoutesSearchResponse()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var routesTableView: UITableView!
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

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
        
        rome2RioClient.getRoutes(from: origin, to: destination, options: options) { (searchResult, error) in
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath)

        // Prepare data
        //let route = searchResult.routes[indexPath.row]
        guard let airSegment = searchResult.airSegment() else {
            return cell
        }
        
        let airLeg = airSegment.outbound[indexPath.row] as AirLeg
        
        // Configure the cell
        cell.textLabel?.text = "Operating days: " + String(describing: airLeg.operatingDays)
  //      cell.detailTextLabel?.text = route.segments

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

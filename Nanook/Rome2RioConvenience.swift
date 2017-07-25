//
//  Rome2RioConvenience.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-28.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

extension Rome2RioClient {
    
    func getPlacesFor(_ query: String, completion: @escaping (_ places: [Place]?, _ error: NSError?) -> Void) {
        
        // Define method
        let method = Constants.Rome2RioMethods.autocomplete
        
        // Set the parameters
        let methodParameters = [
            Constants.Rome2RioAutocompleteParameters.key : Constants.Rome2RioAPIValues.APIKey,
            Constants.Rome2RioAutocompleteParameters.query : query
        ] as [String: AnyObject]
        
        // Build the URL
        let url = rome2RioURLFromParameters(methodParameters, withPathExtension: method)

        // Build the URL request
        let request = URLRequest(url: url)
        
        let _ = taskForRome2RioGET(request) { (parsedResult, error) in
            
            func sendError(_ error: String, code: Int) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                completion(nil, NSError(domain: "getPlacesFor", code: code, userInfo: userInfo))
            }
            
            // Was there an error during request?
            guard (error == nil) else {
                sendError("Error with request \(error!)", code: error!.code)
                return
            }
            
            // Is there "places" key?
            guard let placesArray = parsedResult?[Constants.Rome2RioAutocompleteResponse.places] as? [[String:AnyObject]] else {
                sendError("Cannot find the key: '\(Constants.Rome2RioAutocompleteResponse.places)' in \(parsedResult!)", code: 21)
                return
            }
            
            // Create array of suggested places which fit the search name
            var places = [Place]()
            
            // and populate array of possible places
            for placeDictionary in placesArray {
                let place = Place(place: placeDictionary)
                places.append(place)
            }
            
            completion(places, nil)
        }
    }
    
    func getRoutes(from: String, to: String, options: [String:AnyObject] = [:], completion: @escaping (_ searchResponse: RoutesSearchResponse?, _ error: NSError?) -> Void) {
    
        // Define the method
        let method = Constants.Rome2RioMethods.search
        
        // Set the parameters
        var methodParameters = [
            Constants.Rome2RioSearchParameters.key : Constants.Rome2RioAPIValues.APIKey,
            Constants.Rome2RioSearchParameters.oName : from,
            Constants.Rome2RioSearchParameters.dName : to
            ] as [String: AnyObject]
        
        // Add options to the parameters' list
        for key in options.keys {
            methodParameters[key] = options[key]
        }
        
        
        // Build the URL
        let url = rome2RioURLFromParameters(methodParameters, withPathExtension: method)
        
        // Build the URL request
        let request = URLRequest(url: url)
        
        let _ = taskForRome2RioGET(request) { (parsedResult, error) in
            
            func sendError(_ error: String, code: Int) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                completion(nil, NSError(domain: "getRoutes", code: code, userInfo: userInfo))
            }
            
            // Was there an error during request?
            guard (error == nil) else {
                sendError("Error with request \(error!)", code: error!.code)
                return
            }
            
            // Convert the parsed results to dictionary
            guard let resultDictionary = parsedResult as? [String:AnyObject] else {
                sendError("Cannot convert result into a dictionary: \(parsedResult!)", code: 22)
                return
            }
            
            // Is there "places" key?
            guard let placesArray = resultDictionary[Constants.Rome2RioSearchResponse.places] as? [[String:AnyObject]] else {
                sendError("Cannont find key '\(Constants.Rome2RioSearchResponse.places)' in \(resultDictionary)", code: 23)
                return
            }
            
            var places = [Place]()
            for placeItem in placesArray {
                let place = Place(place: placeItem)
                places.append(place)
            }
            
            // Check for "airlines" key
            guard let airlinesArray = resultDictionary[Constants.Rome2RioSearchResponse.airlines] as? [[String:AnyObject]] else {
                sendError("Cannot find key '\(Constants.Rome2RioSearchResponse.airlines)' in \(resultDictionary)", code: 24)
                return
            }
            
            var airlines = [Airline]()
            for airlineItem in airlinesArray {
                let airline = Airline(airline: airlineItem)
                airlines.append(airline)
            }
            
            // Is there "aircrafts" key?
            guard let aircraftsArray = resultDictionary[Constants.Rome2RioSearchResponse.aircrafts] as? [[String:AnyObject]] else {
                sendError("Cannont find key '\(Constants.Rome2RioSearchResponse.aircrafts)' in \(resultDictionary)", code: 25)
                return
            }

            var aircrafts = [Aircraft]()
            for aircraftItem in aircraftsArray {
                let aircraft = Aircraft(aircraft: aircraftItem)
                aircrafts.append(aircraft)
            }
            
            // Is there "agencies" key?
            guard let agenciesArray = resultDictionary[Constants.Rome2RioSearchResponse.agencies] as? [[String:AnyObject]] else {
                sendError("Cannont find key '\(Constants.Rome2RioSearchResponse.agencies)' in \(resultDictionary)", code: 26)
                return
            }
            
            var agencies = [Agency]()
            for agencyItem in agenciesArray {
                let agency = Agency(agency: agencyItem)
                agencies.append(agency)
            }
            
            // Is there "vehicles" key?
            guard let vehiclesArray = resultDictionary[Constants.Rome2RioSearchResponse.vehicles] as? [[String:AnyObject]] else {
                sendError("Cannont find key '\(Constants.Rome2RioSearchResponse.vehicles)' in \(resultDictionary)", code: 27)
                return
            }
            
            var vehicles = [Vehicle]()
            for vehicleItem in vehiclesArray {
                let vehicle = Vehicle(vehicle: vehicleItem)
                vehicles.append(vehicle)
            }

            // Is there "routes" key?
            guard let routesArray = resultDictionary[Constants.Rome2RioSearchResponse.routes] as? [[String:AnyObject]] else {
                sendError("Cannont find key '\(Constants.Rome2RioSearchResponse.routes)' in \(resultDictionary)", code: 28)
                return
            }
            
            var routes = [Route]()
            for routeItem in routesArray {
                let route = Route(route: routeItem)
                routes.append(route)
            }
            
            var routesSearchResponse = [String:AnyObject]()
            routesSearchResponse[Constants.Rome2RioSearchResponse.elapsedTime] = resultDictionary[Constants.Rome2RioSearchResponse.elapsedTime]
            routesSearchResponse[Constants.Rome2RioSearchResponse.currencyCode] = resultDictionary[Constants.Rome2RioSearchResponse.currencyCode] as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.languageCode] = resultDictionary[Constants.Rome2RioSearchResponse.languageCode] as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.data] = resultDictionary[Constants.Rome2RioSearchResponse.data] as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.places] = places as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.airlines] = airlines as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.aircrafts] = aircrafts as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.agencies] = agencies as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.vehicles] = vehicles as AnyObject
            routesSearchResponse[Constants.Rome2RioSearchResponse.routes] = routes as AnyObject
            
            let searchResponse = RoutesSearchResponse(routesSearchResponse: routesSearchResponse)
            
            completion(searchResponse, nil)
        }

    }
    
    
    // MARK: Helpers
    
    // Create URL from parameters
    
    private func rome2RioURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Rome2RioAPIValues.APIScheme
        components.host = Constants.Rome2RioAPIValues.APIHost
        components.path = Constants.Rome2RioAPIValues.APIPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}

//
//  SearchResponse.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct RoutesSearchResponse {
    
    
    // MARK: Properties
    
    let elapsedTime: Int
    let currencyCode: String
    let languageCode: String
    let data: String?
    let places: [Place]
    let airlines: [Airline]
    let aircrafts: [Aircraft]
    let agencies: [Agency]
    let vehicles: [Vehicle]
    let routes: [Route]
    
    
    // MARK: Initializers
    
    init() {
        self.elapsedTime = 0
        self.currencyCode = ""
        self.languageCode = ""
        self.data = nil
        self.places = []
        self.airlines = []
        self.aircrafts = []
        self.agencies = []
        self.vehicles = []
        self.routes = []
    }
    
    init(routesSearchResponse: [String:AnyObject]) {
        self.elapsedTime = routesSearchResponse[Constants.Rome2RioSearchResponse.elapsedTime] as! Int
        self.currencyCode = routesSearchResponse[Constants.Rome2RioSearchResponse.currencyCode] as! String
        self.languageCode = routesSearchResponse[Constants.Rome2RioSearchResponse.languageCode] as! String
        self.data = routesSearchResponse[Constants.Rome2RioSearchResponse.data] as? String
        self.places = routesSearchResponse[Constants.Rome2RioSearchResponse.places] as! [Place]
        self.airlines = routesSearchResponse[Constants.Rome2RioSearchResponse.airlines] as! [Airline]
        self.aircrafts = routesSearchResponse[Constants.Rome2RioSearchResponse.aircrafts] as! [Aircraft]
        self.agencies = routesSearchResponse[Constants.Rome2RioSearchResponse.agencies] as! [Agency]
        self.vehicles = routesSearchResponse[Constants.Rome2RioSearchResponse.vehicles] as! [Vehicle]
        self.routes = routesSearchResponse[Constants.Rome2RioSearchResponse.routes] as! [Route]
    }
    
    
    func airSegment() -> AirSegment? {
        
//        var airRoute = Route()
        
        for route in routes {
            if route.segments.count == 1 && route.segments[0].segmentKind == "air" {
                if let airSegment = route.segments[0] as? AirSegment {
                    return airSegment
                }
            }
        }
//        
//        if let airSegment = airRoute.segments[0] as? AirSegment {
//            return airSegment
//        } else {
//            print("No air rotes between the destionations were found")
//            return nil
//        }
        print("No air rotes between the destionations were found")
        return nil

    }

}

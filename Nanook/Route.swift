//
//  Route.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Route {
    
    
    // MARK: Properties
    
    let name: String
    let depPlace: Int
    let arrPlace: Int
    let distance: Double
    let totalDuration: Double
    let totalTransitDuration: Double
    let totalTransferDuration: Double
    let indicativePrices: IndicativePrice?
    let segments: [Segment]
    let alternatives: [[String:AnyObject]]?    //  [Alternative]?

    
    // MARK: Initializers
    
//    init() {
//        self.name = ""
//        self.depPlace = 0
//        self.arrPlace = 0
//        self.distance = 0.0
//        self.totalDuration = 0.0
//        self.totalTransitDuration = 0.0
//        self.totalTransferDuration = 0.0
//        self.indicativePrices = nil
//        self.segments = [];
//        self.alternatives = nil
//    }
    
    init(route: [String:AnyObject]) {
        self.name = route[Constants.Route.name] as! String
        self.depPlace = route[Constants.Route.depPlace] as! Int
        self.arrPlace = route[Constants.Route.arrPlace] as! Int
        self.distance = route[Constants.Route.distance] as! Double
        self.totalDuration = route[Constants.Route.totalDuration] as! Double
        self.totalTransitDuration = route[Constants.Route.totalTransitDuration] as! Double
        self.totalTransferDuration = route[Constants.Route.totalTransferDuration] as! Double
        
        // Convert array of dictionaries of idicative prices to array of object of the same type
//        if let indicativePricesArray = route[Constants.Route.indicativePrices] as? [[String:AnyObject]] {
//            var indicativePrices = [IndicativePrice]()
//            for indicativePriceItem in indicativePricesArray {
//                let indicativePrice = IndicativePrice(indicativePrice: indicativePriceItem)
//                indicativePrices.append(indicativePrice)
//            }
//            self.indicativePrices = indicativePrices
//        } else {
//            self.indicativePrices = nil
//        }
        
        if let indicativePricesArray = route[Constants.Route.indicativePrices] as? [[String:AnyObject]] {
//            var indicativePrices = [IndicativePrice]()
//            for indicativePriceItem in indicativePricesArray {
                let indicativePrices = IndicativePrice(indicativePrice: indicativePricesArray.first!)
//                indicativePrices.append(indicativePrice)
//            }
            self.indicativePrices = indicativePrices
        } else {
            self.indicativePrices = nil
        }
//        let indicativePriceArray =
//        let indicativePrice = IndicativePrice(indicativePrice: route[Constants.Route.indicativePrices] as! [[String:AnyObject]])
//        self.indicativePrices = indicativePrice
    
        // Convert array of segment dictionaries to arrays of segment objects
        if let segmentsArray = route[Constants.Route.segments] as? [[String:AnyObject]] {
            var segments = [Segment]()
            for segmentItem in segmentsArray {
                let segmentKind = segmentItem[Constants.Segment.segmentKind] as! String // Either "surface" or "air"
                
                if segmentKind == Constants.AirSegment.segmentKind {
                    let segment = AirSegment(segment: segmentItem)
                    segments.append(segment)
                } else {
                    let segment = SurfaceSegment(segment: segmentItem)
                    segments.append(segment)
                }
            }
            self.segments = segments
        } else {
            self.segments = []
            print("Segments cannot be nil")
        }
        
        // We will convert them late on demand
        self.alternatives = route[Constants.Route.alternatives] as? [[String:AnyObject]]  //  [Alternative]
    }
}

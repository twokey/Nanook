//
//  Segment.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-05.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

class Segment {
    
    
    // MARK: Properties

    let segmentKind: String
    let depPlace: Int
    let arrPlace: Int
    let vehicle: Int
    let distance: Double
    let transitDuration: Double
    let transferDuration: Double
    let indicativePrices: IndicativePrice?


    // MARK: Initializers

    init(segment: [String:AnyObject]) {
        self.segmentKind = segment[Constants.Segment.segmentKind] as! String
        self.depPlace = segment[Constants.Segment.depPlace] as! Int
        self.arrPlace = segment[Constants.Segment.arrPlace] as! Int
        self.vehicle = segment[Constants.Segment.vehicle] as! Int
        self.distance = segment[Constants.Segment.distance] as! Double
        self.transitDuration = segment[Constants.Segment.transferDuration] as! Double
        self.transferDuration = segment[Constants.Segment.transferDuration] as! Double
        
        if let indicativePricesArray = segment[Constants.Segment.indicativePrices] as? [[String:AnyObject]] {
            let indicativePrices = IndicativePrice(indicativePrice: indicativePricesArray.first!)
            self.indicativePrices = indicativePrices
        } else {
            self.indicativePrices = nil
        }

//        self.indicativePrices = segment[Constants.Segment.indicativePrices] as? IndicativePrice
    }
}

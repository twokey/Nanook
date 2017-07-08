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
    let distance: Float
    let transitDuration: Float
    let transferDuration: Float
    let indicativePrices: [IndicativePrice]?


    // MARK: Initializers

    init(segment: [String:AnyObject]) {
        self.segmentKind = segment[Constants.Segment.segmentKind] as! String
        self.depPlace = segment[Constants.Segment.depPlace] as! Int
        self.arrPlace = segment[Constants.Segment.arrPlace] as! Int
        self.vehicle = segment[Constants.Segment.vehicle] as! Int
        self.distance = segment[Constants.Segment.distance] as! Float
        self.transitDuration = segment[Constants.Segment.transferDuration] as! Float
        self.transferDuration = segment[Constants.Segment.transferDuration] as! Float
        self.indicativePrices = segment[Constants.Segment.indicativePrices] as? [IndicativePrice]
    }
}

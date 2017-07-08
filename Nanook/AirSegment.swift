//
//  Segment.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-04.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

class AirSegment: Segment {
    
    
    // MARK: Properties

    let outbound: [AirLeg]
    let returnSegment: [[String:AnyObject]]   //  [AirLeg]
    
    
    // MARK: Initializers
    
    override init(segment: [String:AnyObject]) {

        // Convert array of dictionaries of air legs to array of object of the same type
        if let airLegsArray = segment[Constants.AirSegment.outbound] as? [[String:AnyObject]] {
            var outbound = [AirLeg]()
            for airLegItem in airLegsArray {
                let airLeg = AirLeg(airLeg: airLegItem)
                outbound.append(airLeg)
            }
            self.outbound = outbound
        } else {
            self.outbound = []
        }

        // self.outbound = segment[Constants.AirSegment.outbound] as! [[String:AnyObject]]   //  [AirLeg]
        self.returnSegment = segment[Constants.AirSegment.returnSegment] as! [[String:AnyObject]]   //  [AirLeg]
        
        super.init(segment: segment)
    }
}

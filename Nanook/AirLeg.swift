//
//  AirLeg.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-04.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct AirLeg {
    
    
    // MARK: Properties
    
    let operatingDays: Int?
    let indicativePrices: [IndicativePrice]?
    let hops: [AirHop]
    
    
    // MARK: Initializers
    
    init(airLeg: [String:AnyObject]) {
        self.operatingDays = airLeg[Constants.AirLeg.operatingDays] as? Int
        self.indicativePrices = airLeg[Constants.AirLeg.indicativePrices] as? [IndicativePrice]
        
        // Convert array of dictionaries of air hops to array of object of the same type
        if let hopsArray = airLeg[Constants.AirLeg.hops] as? [[String:AnyObject]] {
            var hops = [AirHop]()
            for hopItem in hopsArray {
                let hop = AirHop(airHop: hopItem)
                hops.append(hop)
            }
            self.hops = hops
        } else {
            self.hops = []
        }

        // self.hops = airLeg[Constants.AirLeg.hops] as! [AirHop]
    }
}

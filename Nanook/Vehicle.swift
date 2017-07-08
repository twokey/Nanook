//
//  Vehicle.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Vehicle {
    
    
    // MARK: Properties
    
    let name: String
    let kind: String    /*  The following kinds are supported: unknown, plane,
                        helicopter, car, bus, taxi, rideshare, shuttle, towncar, 
                        train, tram, cablecar, subway, ferry, foot, animal, bicycle. 
                        Please note that this list will likely change in future revisions. */
    
    
    // MARK: Initializers
    
    init(vehicle: [String:AnyObject]) {
        self.name = vehicle[Constants.Vehicle.name] as! String
        self.kind = vehicle[Constants.Vehicle.kind] as! String
    }
}

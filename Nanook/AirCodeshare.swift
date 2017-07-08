//
//  AirCodeshare.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-05.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct AirCodeshare {
    
    
    // MARK: Properties
    
    let airline: Int
    let flight: String
    
    
    // MARK: Initializers
    
    init(airCodeshare: [String:AnyObject]) {
        //print(airCodeshare)
        self.airline = airCodeshare[Constants.AirCodeshare.airline] as! Int
        self.flight = String(describing: airCodeshare[Constants.AirCodeshare.airline])
    }
}

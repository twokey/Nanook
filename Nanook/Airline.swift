//
//  Airline.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Airline {
    
    
    // MARK: Properties
    
    let code: String
    let name: String
    let url: String?
    let icon: String?
    
    
    // MARK: Initializers
    
    init(airline: [String:AnyObject]) {
        self.code = airline[Constants.Airline.code] as! String
        self.name = airline[Constants.Airline.name] as! String
        self.url = airline[Constants.Airline.url] as? String
        self.icon = airline[Constants.Airline.icon] as? String
    }
}

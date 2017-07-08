//
//  Aircraft.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Aircraft {
    
    
    // MARK: Properties
    
    let code: String
    let manufacturer: String
    let model: String
    
    
    // MARK: Initializers
    
    init(aircraft: [String:AnyObject]) {
        self.code = aircraft[Constants.Aircraft.code] as! String
        self.manufacturer = aircraft[Constants.Aircraft.manufacturer] as! String
        self.model = aircraft[Constants.Aircraft.model] as! String
    }
}

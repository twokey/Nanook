//
//  Alternative.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-04.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Alternative {
    
    
    // MARK: Properites
    
    let firstSegment: Int
    let lastSegment: Int
    let route: Route
    
    
    // MARK: Initializers
    
    init(alternative: [String:AnyObject]) {
        self.firstSegment = alternative[Constants.Alternative.firstSegment] as! Int
        self.lastSegment = alternative[Constants.Alternative.lastSegment] as! Int
        self.route = alternative[Constants.Alternative.route] as! Route
    }
}

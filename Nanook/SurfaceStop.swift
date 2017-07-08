//
//  SurfaceStop.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-05.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct SurfaceStop {
    
    
    // MARK: Properties
    
    let place: Int
    let transitDuration: Float
    let stopDuration: Float

    
    // MARK: Initializers
    
    init(surfaceStop: [String:AnyObject]) {
        self.place = surfaceStop[Constants.SurfaceStop.place] as! Int
        self.transitDuration = surfaceStop[Constants.SurfaceStop.transitDuration] as! Float
        self.stopDuration = surfaceStop[Constants.SurfaceStop.stopDuration] as! Float
    }

}

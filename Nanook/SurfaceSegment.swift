//
//  SurfaceSegment.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-05.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

class SurfaceSegment: Segment {
    
    
    // MARK: Properties
    
    let stops: [SurfaceStop]?
    let agencies: [SurfaceAgency]?
    
    
    // MARK: Initializers
    
    override init(segment: [String : AnyObject]) {
        
        self.stops = segment[Constants.SurfaceSegment.stops] as? [SurfaceStop]
        self.agencies = segment[Constants.SurfaceSegment.agencies] as? [SurfaceAgency]
        
        super.init(segment: segment)
    }
}

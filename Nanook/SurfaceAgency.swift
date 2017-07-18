//
//  SurfaceAgency.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-05.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct SurfaceAgency {
    
    
    // MARK: Properties
    
    let agency: Int
    let frequency: Double?
    let duration: Double?
    let operatingDays: Int?
    let lineNames: [String]?
    let lineCodes: [String]?
    let links: [URL]?

    
    // MARK: Initializers

    init(surfaceAgency: [String:AnyObject]) {
        self.agency = surfaceAgency[Constants.SurfaceAgency.agency] as! Int
        self.frequency = surfaceAgency[Constants.SurfaceAgency.frequency] as? Double
        self.duration = surfaceAgency[Constants.SurfaceAgency.duration] as? Double
        self.operatingDays = surfaceAgency[Constants.SurfaceAgency.operatingDays] as? Int
        self.lineNames = surfaceAgency[Constants.SurfaceAgency.lineNames] as? [String]
        self.lineCodes = surfaceAgency[Constants.SurfaceAgency.lineCodes] as? [String]
        self.links = surfaceAgency[Constants.SurfaceAgency.links] as? [URL]
    }
}

//
//  Place.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-28.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Place {
    
    
    // MARK: Properties

    let kind: String
    let shortName: String
    let longName: String?
    let canonicalName: String?
    let code: String?
    let latitude: Float
    let longitude: Float
    let radius: Float?
    let regionName: String?
    let regionCode: String?
    let countryName: String?
    let countryCode: String?
    let timeZone: String? // Time zone (IANA)
    
    
    // MARK: Initializers
    
    init(place: [String:AnyObject]) {
        self.kind = place[Constants.Rome2RioPlace.kind] as! String
        self.shortName = place[Constants.Rome2RioPlace.shortName] as! String
        self.longName = place[Constants.Rome2RioPlace.longName] as? String
        self.canonicalName = place[Constants.Rome2RioPlace.canonicalName] as? String
        self.code = place[Constants.Rome2RioPlace.code] as? String
        self.latitude = place[Constants.Rome2RioPlace.latitude] as! Float
        self.longitude = place[Constants.Rome2RioPlace.longitude] as! Float
        self.radius = place[Constants.Rome2RioPlace.radius] as? Float
        self.regionName = place[Constants.Rome2RioPlace.regionName] as? String
        self.regionCode = place[Constants.Rome2RioPlace.regionCode] as? String
        self.countryName = place[Constants.Rome2RioPlace.countryName] as? String
        self.countryCode = place[Constants.Rome2RioPlace.countryCode] as? String
        self.timeZone = place[Constants.Rome2RioPlace.timeZone] as? String
    }
}

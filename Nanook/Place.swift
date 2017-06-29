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
    let longName: String
    let canonicalName: String
    let code: String
    let latitude: Float
    let longitude: Float
    let radius: Float
    let regionName: String
    let regionCode: String
    let countryName: String
    let countryCode: String
    
    
    // MARK: Initializers
    
    init(place: [String:AnyObject]) {
        self.kind = place[Constants.Rome2RioPlace.Kind] as! String
        self.shortName = place[Constants.Rome2RioPlace.ShortName] as! String
        self.longName = place[Constants.Rome2RioPlace.LongName] as! String
        self.canonicalName = place[Constants.Rome2RioPlace.CanonicalName] as! String
        self.code = place[Constants.Rome2RioPlace.Code] as? String ?? ""
        self.latitude = place[Constants.Rome2RioPlace.Latitude] as! Float
        self.longitude = place[Constants.Rome2RioPlace.Longitude] as! Float
        self.radius = place[Constants.Rome2RioPlace.Radius] as! Float
        self.regionName = place[Constants.Rome2RioPlace.RegionName] as! String
        self.regionCode = place[Constants.Rome2RioPlace.RegionCode] as! String
        self.countryName = place[Constants.Rome2RioPlace.CountryName] as! String
        self.countryCode = place[Constants.Rome2RioPlace.CountryCode] as! String
    }
}

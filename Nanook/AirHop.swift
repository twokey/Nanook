//
//  AirHop.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-05.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct AirHop {
    
    
    // MARK: Properties

    let depPlace: Int
    let arrPlace: Int
    let depTerminal: String?
    let arrTerminal: String?
    let depTime: String // 24-hour local time - hh:mm
    let arrTime: String // 24-hour local time - hh:mm
    let flight: String
    let duration: Double
    let airline: Int
    let operatingAirline: Int?
    let aircraft: String?
    let dayChange: Int?
    let layoverDuration: Double?
    let layoverDayChange: Int?
    let codeshares: [AirCodeshare]?

    
    // MARK: Initializers
    
    init(airHop: [String:AnyObject]) {
        self.depPlace = airHop[Constants.AirHop.depPlace] as! Int
        self.arrPlace = airHop[Constants.AirHop.arrPlace] as! Int
        self.depTerminal = airHop[Constants.AirHop.depTerminal] as? String
        self.arrTerminal = airHop[Constants.AirHop.arrTerminal] as? String
        self.depTime = airHop[Constants.AirHop.depTime] as! String
        self.arrTime = airHop[Constants.AirHop.arrTime] as! String
        self.flight = airHop[Constants.AirHop.flight] as! String
        self.duration = airHop[Constants.AirHop.duration] as! Double
        self.airline = airHop[Constants.AirHop.airline] as! Int
        self.operatingAirline = airHop[Constants.AirHop.operatingAirline] as? Int
        self.aircraft = airHop[Constants.AirHop.aircraft] as? String
        self.dayChange = airHop[Constants.AirHop.dayChange] as? Int
        self.layoverDuration = airHop[Constants.AirHop.layoverDuration] as? Double
        self.layoverDayChange = airHop[Constants.AirHop.layoverDayChange] as? Int
        
        // Convert array of dictionaries of air codeshares to array of object of the same type
        if let airCodesharesArray = airHop[Constants.AirHop.codeshares] as? [[String:AnyObject]] {
            var codeshares = [AirCodeshare]()
            for airCodeshareItem in airCodesharesArray {
                let airCodeshare = AirCodeshare(airCodeshare: airCodeshareItem)
                codeshares.append(airCodeshare)
            }
            self.codeshares = codeshares
        } else {
            self.codeshares = nil
        }
    }
        
    // Return total leg duration as a String
    func durationString() -> String {
        let duration: TimeInterval = self.duration * 60.0
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: duration)!
    }
    
    func layoverDurationString() -> String {
        var duration: TimeInterval = 0
        if let layoverDuration = self.layoverDuration {
            duration = layoverDuration * 60
        }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: duration)!
    }
}

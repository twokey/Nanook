//
//  AirLeg.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-04.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct AirLeg {
    
    
    // MARK: Properties
    
    let operatingDays: [String]?
    let indicativePrices: IndicativePrice?
    let hops: [AirHop]
    
    
    // MARK: Initializers
    
    init(airLeg: [String:AnyObject]) {
        
        struct Days: OptionSet {
            
            var rawValue: Int
            
            init(rawValue: Int) {
                self.rawValue = rawValue
            }
            
            static let Monday = Days(rawValue: 1<<1)
            static let Tuesday = Days(rawValue: 1<<2)
            static let Wednesday = Days(rawValue: 1<<3)
            static let Thursday = Days(rawValue: 1<<4)
            static let Friday = Days(rawValue: 1<<5)
            static let Saturday = Days(rawValue: 1<<6)
            static let Sunday = Days(rawValue: 1<<0)
        }
        
        func markDaysAsSelectedWith(days: Days) -> [String]? {
            
            var operatingDays = [String]()
            
            if days.contains(.Monday) {
                operatingDays.append("Mon")
            }
            if days.contains(.Tuesday) {
                operatingDays.append("Tue")
            }
            if days.contains(.Wednesday) {
                operatingDays.append("Wed")
            }
            if days.contains(.Thursday) {
                operatingDays.append("Thu")
            }
            if days.contains(.Friday) {
                operatingDays.append("Fri")
            }
            if days.contains(.Saturday) {
                operatingDays.append("Sat")
            }
            if days.contains(.Sunday) {
                operatingDays.append("Sun")
            }
            
            if operatingDays.count > 0 {
                return operatingDays
            } else {
                return nil
            }
        }

        // Initialize operating days with arrays of human readable namve of week based on flag
        if let operatingDaysFlags = airLeg[Constants.AirLeg.operatingDays] as? Int {
            let days = Days(rawValue: operatingDaysFlags)
            self.operatingDays = markDaysAsSelectedWith(days: days)
        } else {
            self.operatingDays = nil
        }
        
//        self.indicativePrices = airLeg[Constants.AirLeg.indicativePrices] as? IndicativePrice
        
        if let indicativePricesArray = airLeg[Constants.AirLeg.indicativePrices] as? [[String:AnyObject]] {
            let indicativePrices = IndicativePrice(indicativePrice: indicativePricesArray.first!)
            self.indicativePrices = indicativePrices
        } else {
            self.indicativePrices = nil
        }

        // Convert array of dictionaries of air hops to array of object of the same type
        if let hopsArray = airLeg[Constants.AirLeg.hops] as? [[String:AnyObject]] {
            var hops = [AirHop]()
            for hopItem in hopsArray {
                let hop = AirHop(airHop: hopItem)
                hops.append(hop)
            }
            self.hops = hops
        } else {
            self.hops = []
        }

    }
    
    // Combine all operating days into one string
    
    func operatingDaysString() -> String {
        var operatingDaysString = ""
        
        if let operatingDays = operatingDays {
            for day in operatingDays {
                operatingDaysString = operatingDaysString + day + "., "
            }
        }
        
        return operatingDaysString
    }
    
    // Calculate duration for a leg in minutes
    func duration() -> Double {
        var duration = 0.0
        for hop in hops {
            let layoverDuration = hop.layoverDuration ?? 0.0
            duration = duration + hop.duration + layoverDuration
        }
        return duration
    }
    
    // Return total leg duration as a String
    func durationString() -> String {
        let legDuration: TimeInterval = self.duration() * 60.0
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: legDuration)!
    }
}

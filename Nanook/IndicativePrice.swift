//
//  IndicativePrice.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-04.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct IndicativePrice {
    
    
    // MARK: Properties
    let name: String?
    let price: Double
    let priceLow: Double?
    let priceHigh: Double?
    let currency: String
    let nativePrice: Double?
    let nativePriceLow: Double?
    let nativePriceHigh: Double?
    let nativeCurrency: String?


    // MARK: Initializers

    init(indicativePrice: [String:AnyObject]) {
        self.name = indicativePrice[Constants.IndicativePrice.name] as? String
        self.price = indicativePrice[Constants.IndicativePrice.price] as! Double
        self.priceLow = indicativePrice[Constants.IndicativePrice.priceLow] as? Double
        self.priceHigh = indicativePrice[Constants.IndicativePrice.priceHigh] as? Double
        self.currency = indicativePrice[Constants.IndicativePrice.currency] as! String
        self.nativePrice = indicativePrice[Constants.IndicativePrice.nativePrice] as? Double
        self.nativePriceLow = indicativePrice[Constants.IndicativePrice.nativePriceLow] as? Double
        self.nativePriceHigh = indicativePrice[Constants.IndicativePrice.nativePriceHigh] as? Double
        self.nativeCurrency = indicativePrice[Constants.IndicativePrice.nativeCurrency] as? String
    }
}

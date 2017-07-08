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
    let price: Float
    let priceLow: Float?
    let priceHigh: Float?
    let currency: String
    let nativePrice: Float?
    let nativePriceLow: Float?
    let nativePriceHigh: Float?
    let nativeCurrency: String?


    // MARK: Initializers

    init(indicativePrice: [String:AnyObject]) {
        self.name = indicativePrice[Constants.IndicativePrice.name] as? String
        self.price = indicativePrice[Constants.IndicativePrice.price] as! Float
        self.priceLow = indicativePrice[Constants.IndicativePrice.priceLow] as? Float
        self.priceHigh = indicativePrice[Constants.IndicativePrice.priceHigh] as? Float
        self.currency = indicativePrice[Constants.IndicativePrice.currency] as! String
        self.nativePrice = indicativePrice[Constants.IndicativePrice.nativePrice] as? Float
        self.nativePriceLow = indicativePrice[Constants.IndicativePrice.nativePriceLow] as? Float
        self.nativePriceHigh = indicativePrice[Constants.IndicativePrice.nativePriceHigh] as? Float
        self.nativeCurrency = indicativePrice[Constants.IndicativePrice.nativeCurrency] as? String
    }
}

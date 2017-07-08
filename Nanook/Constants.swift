//
//  Constants.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-28.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Rome2RioAPIValues {
        static let APIKey = "lZVKynf6"
        static let APIScheme = "https"
        static let APIHost = "free.rome2rio.com"
        static let APIPath = "/api/1.4/json/"
    }
    
    struct Rome2RioMethods {
        static let autocomplete = "Autocomplete"
        static let geocode = "Geocode"
        static let search = "Search"
    }
    
    struct Rome2RioAutocompleteParameters {
        static let key = "key"
        static let query = "query"
        static let countryCode = "countryCode"
        static let languageCode = "languageCode"
    }
    
    struct Rome2RioAutocompleteResponse {
        static let query = "query"
        static let countryCode = "countryCode"
        static let languageCode = "languageCode"
        static let places = "places"
    }
    
    struct Rome2RioSearchParameters {
        static let key = "key"
        static let oName = "oName"
        static let dName = "dName"
        static let oPos = "oPos"
        static let dPos = "dPos"
        static let oKind = "oKind"
        static let dKind = "dKind"
        static let currencyCode = "currencyCode"
        static let languageCode = "languageCode"
        static let data = "data"
        static let noAir = "noAir"
        static let noAirLeg = "noAirLeg"
        static let noRail = "noRail"
        static let noBus = "noBus"
        static let noFerry = "noFerry"
        static let noCar = "noCar"
        static let noBikeshare = "noBikeshare"
        static let noRideshare = "noRideshare"
        static let noTowncar = "noTowncar"
        static let noCommuter = "noCommuter"
        static let noSpecial = "noSpecial"
        static let noMinorStart = "noMinorStart"
        static let noMinorEnd = "noMinorEnd"
        static let noPath = "noPath"
        static let noPrice = "noPrice"
        static let noStop = "noStop"
    }
    
    struct Rome2RioSearchResponse {
        static let elapsedTime = "elapsedTime"
        static let currencyCode = "currencyCode"
        static let languageCode = "languageCode"
        static let data = "data"
        static let places = "places"
        static let airlines = "airlines"
        static let aircrafts = "aircrafts"
        static let agencies = "agencies"
        static let vehicles = "vehicles"
        static let routes = "routes"
    }
    
    struct Airline {
        static let code = "code"
        static let name = "name"
        static let url = "url"
        static let icon = "icon"
    }
    
    struct Aircraft {
        static let code = "code"
        static let manufacturer = "manufacturer"
        static let model = "model"
    }
    
    struct Agency {
        static let name = "name"
        static let url = "url"
        static let phone = "phone"
        static let icon = "icon"
    }
    
    struct Vehicle {
        static let name = "name"
        static let kind = "kind"
    }
    
    struct Route {
        static let name = "name"
        static let depPlace = "depPlace"
        static let arrPlace = "arrPlace"
        static let distance = "distance"
        static let totalDuration = "totalDuration"
        static let totalTransitDuration = "totalTransitDuration"
        static let totalTransferDuration = "totalTransferDuration"
        static let indicativePrices = "indicativePrices"
        static let segments = "segments"
        static let alternatives = "alternatives"
    }
    
    struct Segment {
        static let segmentKind = "segmentKind"
        static let depPlace = "depPlace"
        static let arrPlace = "arrPlace"
        static let vehicle = "vehicle"
        static let distance = "distance"
        static let transitDuration = "transitDuration"
        static let transferDuration = "transferDuration"
        static let indicativePrices = "indicativePrices"
    }
    
    struct SurfaceSegment {
        static let segmentKind = "surface"
        static let depPlace = "depPlace"
        static let arrPlace = "arrPlace"
        static let vehicle = "vehicle"
        static let distance = "distance"
        static let transitDuration = "transitDuration"
        static let transferDuration = "transferDuration"
        static let path = "path"
        static let indicativePrices = "indicativePrices"
        static let stops = "stops"
        static let agencies = "agencies"
    }
    
    struct AirSegment {
        static let segmentKind = "air"
        static let depPlace = "depPlace"
        static let arrPlace = "arrPlace"
        static let vehicle = "vehicle"
        static let distance = "distance"
        static let transitDuration = "transitDuration"
        static let transferDuration = "transferDuration"
        static let indicativePrices = "indicativePrices"
        static let outbound = "outbound"
        static let returnSegment = "return"
    }
    
    struct Alternative {
        static let firstSegment = "firstSegment"
        static let lastSegment = "lastSegment"
        static let route = "route"
    }
    
    struct SurfaceStop {
        static let place = "place"
        static let transitDuration = "transitDuration"
        static let stopDuration = "stopDuration"
    }
    
    struct SurfaceAgency {
        static let agency = "agency"
        static let frequency = "frequency"
        static let duration = "duration"
        static let operatingDays = "operatingDays"
        static let lineNames = "lineNames"
        static let lineCodes = "lineCodes"
        static let links = "links"
    }
    
    struct SurfaceLineName {
        static let name = "name"
    }
    
    struct SurfaceLineCode {
        static let code = "code"
    }
    
    struct AirLeg {
        static let operatingDays = "operatingDays"
        static let indicativePrices = "indicativePrices"
        static let hops = "hops"
    }
    
    struct AirHop {
        static let depPlace = "depPlace"
        static let arrPlace = "arrPlace"
        static let depTerminal = "depTerminal"
        static let arrTerminal = "arrTerminal"
        static let depTime = "depTime"
        static let arrTime = "arrTime"
        static let flight = "flight"
        static let duration = "duration"
        static let airline = "airline"
        static let operatingAirline = "operatingAirline"
        static let aircraft = "aircraft"
        static let dayChange = "dayChange"
        static let layoverDuration = "layoverDuration"
        static let layoverDayChange = "layoverDayChange"
        static let codeshares = "codeshares"
    }
    
    struct AirCodeshare {
        static let airline = "airline"
        static let flight = "flight"
    }
    
    struct ExternalLink {
        static let text = "text"
        static let url = "url"
        static let displayUrl = "displayUrl"
        static let moustacheUrl = "moustacheUrl"
    }
    
    struct IndicativePrice {
        static let name = "name"
        static let price = "price"
        static let priceLow = "priceLow"
        static let priceHigh = "priceHigh"
        static let currency = "currency"
        static let nativePrice = "nativePrice"
        static let nativePriceLow = "nativePriceLow"
        static let nativePriceHigh = "nativePriceHigh"
        static let nativeCurrency = "nativeCurrency"
    }
    
    struct Icon{
        static let Name = "Name"
        static let url = "url"
        static let x = "x"
        static let y = "y"
        static let w = "w"
        static let h = "h"
    }
        
    struct Rome2RioPlace {
        static let kind = "kind"
        static let shortName = "shortName"
        static let longName = "longName"
        static let canonicalName = "canonicalName"
        static let code = "code"
        static let latitude = "lat"
        static let longitude = "lng"
        static let radius = "rad"
        static let regionName = "regionName"
        static let regionCode = "regionCode"
        static let countryName = "countryName"
        static let countryCode = "countryCode"
        static let timeZone = "timeZone"
    }
}

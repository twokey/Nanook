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
        static let Autocomplete = "Autocomplete"
        static let Geocode = "Geocode"
        static let Search = "Search"
    }
    
    struct Rome2RioAutocompleteParameters {
        static let Key = "key"
        static let Query = "query"
        static let CountryCode = "countryCode"
        static let LanguageCode = "languageCode"
    }
    
    struct Rome2RioAutocompleteResponse {
        static let Query = "query"
        static let CountryCode = "countryCode"
        static let LanguageCode = "languageCode"
        static let Places = "places"
    }
    
    struct Rome2RioPlace {
        static let Kind = "kind"
        static let ShortName = "shortName"
        static let LongName = "longName"
        static let CanonicalName = "canonicalName"
        static let Code = "code"
        static let Latitude = "lat"
        static let Longitude = "lng"
        static let Radius = "rad"
        static let RegionName = "regionName"
        static let RegionCode = "regionCode"
        static let CountryName = "countryName"
        static let CountryCode = "countryCode"
    }
}
    

//        struct FlickrParameterKeys {
//            static let Method = "method"
//            static let APIKey = "api_key"
//            static let GalleryID = "gallery_id"
//            static let Extras = "extras"
//            static let Format = "format"
//            static let NoJSONCallback = "nojsoncallback"
//            static let SafeSearch = "safe_search"
//            static let Text = "text"
//            static let BoundingBox = "bbox"
//            static let Page = "page"
//            static let PerPage = "per_page"
//        }
//        
//        struct FlickrParameterValues {
//            static let SearchMethod = "flickr.photos.search"
//            static let APIKey = "787b8a0c4f1436d4599a7be8c3b17c2b"
//            static let ResponseFormat = "json"
//            static let DisableJSONCallback = "1" /* 1 means "yes" */
//            static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
//            static let GalleryID = "5704-72157622566655097"
//            static let MediumURL = "url_m"
//            static let ResultsPerPage = "20"
//            static let UseSafeSearch = "1"
//        }
//        
//        struct FlickrResponseKeys {
//            static let Status = "stat"
//            static let Photos = "photos"
//            static let Photo = "photo"
//            static let Title = "title"
//            static let MediumURL = "url_m"
//            static let Pages = "pages"
//            static let Total = "total"
//        }
//        
//        struct FlickrResponseValues {
//            static let OKStatus = "ok"
//        }

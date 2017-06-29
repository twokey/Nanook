//
//  Rome2RioConvenience.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-28.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

extension Rome2RioClient {
    
    func getPlacesFor(_ query: String, completion: @escaping (_ places: [Place]?, _ error: NSError?) -> Void) {
        
        // Define method
        let method = Constants.Rome2RioMethods.Autocomplete
        
        // Set the parameters
        let methodParameters = [
            Constants.Rome2RioAutocompleteParameters.Key : Constants.Rome2RioAPIValues.APIKey,
            Constants.Rome2RioAutocompleteParameters.Query : query
        ] as [String: AnyObject]
        
        // Build the URL
        let url = rome2RioURLFromParameters(methodParameters, withPathExtension: method)

        // Build the URL request
        let request = URLRequest(url: url)
        
        let _ = taskForRome2RioGET(request) { (parsedResult, error) in
            
            func sendError(_ error: String, code: Int) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completion(nil, NSError(domain: "getPlacesFor", code: code, userInfo: userInfo))
            }
            
            // Was there an error during request?
            guard (error == nil) else {
                sendError("Error with request \(error!)", code: error!.code)
                return
            }
            
            // Is there "places" key?
            guard let placesArray = parsedResult?[Constants.Rome2RioAutocompleteResponse.Places] as? [[String:AnyObject]] else {
                sendError("Cannot find the key: '\(Constants.Rome2RioAutocompleteResponse.Places)' in \(parsedResult!)", code: 21)
                return
            }
            
            // Create array of suggested places which fit the search name
            var places = [Place]()
            
            // and populate array of possible places
            for placeDictionary in placesArray {
                let place = Place(place: placeDictionary)
                places.append(place)
            }
            
            completion(places, nil)
        }
    }
    
    
    // MARK: Helpers
    
    // Create URL from parameters
    
    private func rome2RioURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Rome2RioAPIValues.APIScheme
        components.host = Constants.Rome2RioAPIValues.APIHost
        components.path = Constants.Rome2RioAPIValues.APIPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    

}

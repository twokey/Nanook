//
//  Rome2RioClient.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-28.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

class Rome2RioClient: NSObject {
    
    
    // MARK: Properties
    
    // Shared URL session
    let session = URLSession.shared
    
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    
    // MARK: GET method
    
    func taskForRome2RioGET(_ request: URLRequest, completionForRequest: @escaping (_ parsedResult: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        // Create data task
        let task = session.dataTask(with: request) { (data, response, error) in
            
            func sendError(_ error: String, code: Int) {
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionForRequest(nil, NSError(domain: "taskForRome2RioGETRequest", code: code, userInfo: userInfo))
            }
            
            // Was there an error?
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)", code: 10)
                return
            }
            
            // Did we get a successful 2xx response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx", code: (response as? HTTPURLResponse)!.statusCode)
                return
            }
            
            // Was there any data returned?
            guard let data = data else {
                sendError("No data was returned by the request", code: 11)
                return
            }
            
            // Parse the data and use the data (happens in completion handler)
            self.convert(data, withCompletionForParseData: completionForRequest)
        }
        
        task.resume()
        return task
    }
    
    
    // MARK: Helpers
    
    // Given raw data return JSON object
    private func convert(_ data: Data, withCompletionForParseData: (_ parsedResult: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse the data as JSON: \(data)"]
            withCompletionForParseData(nil, NSError(domain: "convert:data:withCompletionForParseData", code: 1, userInfo: userInfo))
        }
        
        withCompletionForParseData(parsedResult, nil)
    }
}

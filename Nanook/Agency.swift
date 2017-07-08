//
//  Agency.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-06-29.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation

struct Agency {
    
    
    // MARK: Properties

    let name: String
    let url: String?
    let phone: String?
    let icon: String?


    // MARK: Initializers

    init(agency: [String:AnyObject]) {
        self.name = agency[Constants.Agency.name] as! String
        self.url = agency[Constants.Agency.url] as? String
        self.phone = agency[Constants.Agency.phone] as? String
        self.icon = agency[Constants.Agency.icon] as? String
    }
}

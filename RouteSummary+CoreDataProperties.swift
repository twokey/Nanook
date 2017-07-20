//
//  RouteSummary+CoreDataProperties.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-19.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import Foundation
import CoreData


extension RouteSummary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RouteSummary> {
        return NSFetchRequest<RouteSummary>(entityName: "RouteSummary")
    }

    @NSManaged public var arrivalTime: String?
    @NSManaged public var departureTime: String?
    @NSManaged public var operatingDays: String?
    @NSManaged public var price: String?
    @NSManaged public var routeGraph: NSData?
    @NSManaged public var travelTime: String?
    @NSManaged public var origin: String?
    @NSManaged public var destination: String?

}

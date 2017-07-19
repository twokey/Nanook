//
//  AirLegTableViewCell.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-08.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class AirLegTableViewCell: UITableViewCell {

    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var travelTime: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var routeGraph: RouteGraphView!
    @IBOutlet weak var operatingDays: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

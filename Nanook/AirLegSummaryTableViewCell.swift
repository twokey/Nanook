//
//  AirLegSummaryTableViewCell.swift
//  Nanook
//
//  Created by Kirill Kudymov on 2017-07-19.
//  Copyright © 2017 Kirill Kudymov. All rights reserved.
//

import UIKit

class AirLegSummaryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var arrivalTime: UILabel!
    @IBOutlet weak var travelTime: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var routeGraph: UIImageView!
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

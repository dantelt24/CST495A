//
//  CityCell.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/26/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UITableViewCell {
//    @IBOutlet weak var cityNameLabel: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
//    @IBOutlet weak var cityTimeLabel: UILabel!
    @IBOutlet weak var cityTimeLabel: UILabel!
    var citySelection: CityModel!
    
    var tapped: ((CityCell) -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configCell(city: CityModel){
//        cityNameLabel.sizeToFit()
//        cityTimeLabel.sizeToFit()
        cityNameLabel.adjustsFontSizeToFitWidth = true
        cityTimeLabel.adjustsFontSizeToFitWidth = true
        self.citySelection = city
        cityNameLabel.text = city.cityName
        cityTimeLabel.text = city.cityTime
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        tapped?(self)
    }
    
}

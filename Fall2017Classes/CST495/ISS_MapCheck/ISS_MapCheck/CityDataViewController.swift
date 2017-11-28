//
//  CityDataViewController.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/26/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class CityDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var userCity: CityModel!
    var userCityList = [CityModel]()
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        print("City Data View Controller loaded")
//        print(userCity.cityName)
//        print(userCity.cityTime)
        print(userCityList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cityTableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell {
            cell.configCell(city: userCityList[indexPath.row])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCityList.count
    }
    
}

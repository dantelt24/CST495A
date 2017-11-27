//
//  LocationModel.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/16/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit

class LocationModel{

    var locLatitude: String!
    var locLongitude: String!
    
    typealias completeDownload = () -> ()
    let issCurrentURL: String = "http://api.open-notify.org/iss-now.json"
    var baseURL: String = "https://maps.googleapis.com/maps/api/geocode/json?address="
    
    
    init() {
        self.locLatitude = ""
        self.locLongitude = ""
    }
    
//    override init(title: String, subTitle: String, lat: String, lon: String, coordinate: CLLocationCoordinate2D) {
//
//    }
    
    
    func getCurrentISSLocation(completion: @escaping completeDownload){
        print("In get current location function")
//        let queue = DispatchQueue(label: "dantelaceythompson.ISS-MapCheck", qos: .background, attributes: .concurrent)
        Alamofire.request(self.issCurrentURL).responseJSON{response in
            switch response.result{
            case.success(let value):
                print(" success in request: \(response.result)")
                print("Values we got back are: \(value)")
                let json = JSON(value)
//                print(json["iss_position"]["latitude"].stringValue)
                self.locLatitude = json["iss_position"]["latitude"].stringValue
//                print(json["iss_position"]["longitude"].stringValue)
                self.locLongitude = json["iss_position"]["longitude"].stringValue
                completion()
            case.failure(let error):
                print(error)
            }
        }
    }
}

//
//  MapViewController.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/16/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mainMap: MKMapView!
    
    var currentIssLocModel: LocationModel!
    let regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        print("Map view controller loaded")
        print(currentIssLocModel.locLatitude)
        print(currentIssLocModel.locLongitude)
//        let initialLocation = CLLocation(latitude: , longitude: )
        if let lat = currentIssLocModel.locLatitude, let doubleLat = CLLocationDegrees(lat){
            print(doubleLat)
            if let lon = currentIssLocModel.locLongitude, let doubleLon = CLLocationDegrees(lon){
                print(doubleLon)
                let initialLocation = CLLocation(latitude: doubleLat, longitude: doubleLon)
                let pinLocation = CLLocationCoordinate2D(latitude: doubleLat, longitude: doubleLon)
                centerMapOnLocation(Location: initialLocation)
                let pin = LocationPin(title: "Current ISS Location", subtitle: "current Location of ISS", coordinate: pinLocation)
                mainMap.addAnnotation(pin)
            }
        }
    }
    
    func centerMapOnLocation(Location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(Location.coordinate, regionRadius, regionRadius)
        mainMap.setRegion(coordinateRegion, animated: true)
    }
}


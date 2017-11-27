//
//  CityModel.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/26/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation

class CityModel {
    private var _cityName: String!
    private var _cityState: String!
    private var _cityLatitude: String!
    private var _cityLongitude: String!
    private var _cityTime: String!
    
    init() {
        _cityName = ""
        _cityState = ""
        _cityLatitude = ""
        _cityLongitude = ""
        _cityTime = ""
    }
    
    var cityName: String {
        get {
            return _cityName
        }
        set (cn) {
            _cityName = cn
        }
    }
    
    var cityState: String {
        get {
            return _cityState
        }
        set (cs){
            _cityState = cs
        }
    }
    
    var cityLatitude: String {
        get {
            return _cityLatitude
        }
        set(clat) {
            _cityLatitude = clat
        }
    }
    
    var cityLongitude: String {
        get {
            return _cityLongitude
        }
        set(clon) {
            _cityLongitude = clon
        }
    }
    
    var cityTime: String{
        get{
            return _cityTime
        }
        set(time){
            _cityTime = time
        }
    }
}

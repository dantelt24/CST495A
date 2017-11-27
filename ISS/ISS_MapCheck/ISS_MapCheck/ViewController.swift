//
//  ViewController.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/9/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    var gmdk: String!
    var cityString: String!
    let issCurrentURL: String = "http://api.open-notify.org/iss-now.json"
    var baseURL: String = "https://maps.googleapis.com/maps/api/geocode/json?address="
    var passTimesURL: String = "http://api.open-notify.org/iss-pass.json?"
    
    var cityDataInfo = [CityModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cityField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func writeToKC(stringVal: String) -> Bool{
        let savedSuccessful: Bool = KeychainWrapper.standard.set(stringVal, forKey: "GMDK")
        return savedSuccessful
    }
    
    func retrieveFromKC() -> String{
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "GMDK")
        return retrievedString!
    }
    
    @IBAction func getCurrentISSLocation(){
        print("In get current location function")
//        let issLocationModel = LocationModel()
//        issLocationModel.getCurrentISSLocation {
//            print("getting current ISS location details now")
//        }
//        performSegue(withIdentifier: "currentLocSegue", sender: issLocationModel)
        let issLocationModel = LocationModel()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(self.issCurrentURL).responseJSON{response in
            switch response.result{
            case.success(let value):
                print(" success in request: \(response.result)")
                print("Values we got back are: \(value)")
                let json = JSON(value)
                //                print(json["iss_position"]["latitude"].stringValue)
                issLocationModel.locLatitude = json["iss_position"]["latitude"].stringValue
                //                print(json["iss_position"]["longitude"].stringValue)
                issLocationModel.locLongitude = json["iss_position"]["longitude"].stringValue
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.performSegue(withIdentifier: "currentLocSegue", sender: issLocationModel)
            case.failure(let error):
                print(error)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
//        Alamofire puts request on background queue by default and switches to main queue in response.
//        DispatchQueue.global(qos: .background).async {
//            print("This is run on the background queue")
//            issLocationModel.getCurrentISSLocation {
//                print("Getting current ISS Location now")
//            }
//            DispatchQueue.main.async {
//                print("This is run on the main queue, after the previous code in outer block")
//                self.performSegue(withIdentifier: "currentLocSegue", sender: issLocationModel)
//            }
//        }
        
    }
    
    @IBAction func getCityPredictionData(){
        print("In get city Prediction Data")
        if (cityField.text?.isEmpty ?? true) {
            print("TextField is empty")
            let defaults = UserDefaults.standard
            if let userCityString = defaults.string(forKey: "userSettingCity"){
                print(userCityString)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd,yyyy HH:mm:ss"
                gmdk = retrieveFromKC()
                let userTextCityInfo = userCityString.components(separatedBy: ",")
                let googleAddressURL = "\(self.baseURL)\(userCityString)&key=\(gmdk!)"
                print(googleAddressURL)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                Alamofire.request(googleAddressURL).responseJSON{response in
                    switch response.result{
                    case.success(let value):
                        print(" success in request: \(response.result)")
                        //                    print("Values we got back are: \(value)")
                        let json = JSON(value)
                        //                    print(json["results"])
                        print(json["results"][0]["geometry"]["location"]["lat"])
                        print(json["results"][0]["geometry"]["location"]["lng"])
                        let userCityLatitude = json["results"][0]["geometry"]["location"]["lat"].stringValue
                        let userCityLongitude = json["results"][0]["geometry"]["location"]["lng"].stringValue
                        //                  http://api.open-notify.org/iss-pass.json?lat=LAT&lon=LON&n=5
                        let openNotifyCityUrl = "\(self.passTimesURL)lat=\(userCityLatitude)&lon=\(userCityLongitude)&n=5"
                        print(openNotifyCityUrl)
                        Alamofire.request(openNotifyCityUrl).responseJSON{response in
                            switch response.result{
                            case.success(let value):
                                print(" success in request: \(response.result)")
                                print("Values we got back are: \(value)")
                                let json = JSON(value)
                                //                            print(json["response"])
                                //                            print(json["response"])
                                guard let timesArray = json["response"].array else{
                                    print("No times found")
                                    return
                                }
                                print(timesArray)
                                for array in timesArray{
                                    for (key, arrValue) in array {
                                        //                                    print(key, arrValue)
                                        if key == "risetime"{
                                            print(key, arrValue)
                                            let date = Date(timeIntervalSince1970: arrValue.doubleValue)
                                            print(date)
                                            let stringDate = dateFormatter.string(from: date)
                                            //                                        userTimesArray.append(stringDate)
                                            let userCityModel = CityModel()
                                            userCityModel.cityName = userTextCityInfo[0]
                                            userCityModel.cityState = userTextCityInfo[1]
                                            userCityModel.cityName = userTextCityInfo[0]
                                            userCityModel.cityState = userTextCityInfo[1]
                                            userCityModel.cityTime = stringDate
                                            self.cityDataInfo.append(userCityModel)
                                        }
                                    }
                                }
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                self.performSegue(withIdentifier: "cityPredictSegue", sender: self.cityDataInfo)
                            case.failure(let error):
                                print(error)
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    case.failure(let error):
                        print(error)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
            else{
                print("Couldn't retrieve settings from user defaults")
                return
            }
        } else {
            print("TextField isn't empty")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
//            var userTimesArray = [String]()
//            let userCityModel = CityModel()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy HH:mm:ss"
            gmdk = retrieveFromKC()
            let userText = cityField.text!
            let userTextCityInfo = userText.components(separatedBy: ",")
            print(userTextCityInfo)

            let googleAddressURL = "\(self.baseURL)\(userText)&key=\(gmdk!)"
            print(googleAddressURL)
            Alamofire.request(googleAddressURL).responseJSON{response in
                switch response.result{
                case.success(let value):
                    print(" success in request: \(response.result)")
//                    print("Values we got back are: \(value)")
                    let json = JSON(value)
//                    print(json["results"])
                    print(json["results"][0]["geometry"]["location"]["lat"])
                    print(json["results"][0]["geometry"]["location"]["lng"])
                    let userCityLatitude = json["results"][0]["geometry"]["location"]["lat"].stringValue
                    let userCityLongitude = json["results"][0]["geometry"]["location"]["lng"].stringValue
//                  http://api.open-notify.org/iss-pass.json?lat=LAT&lon=LON&n=5
                    let openNotifyCityUrl = "\(self.passTimesURL)lat=\(userCityLatitude)&lon=\(userCityLongitude)&n=5"
                    print(openNotifyCityUrl)
                    Alamofire.request(openNotifyCityUrl).responseJSON{response in
                        switch response.result{
                        case.success(let value):
                            print(" success in request: \(response.result)")
                            print("Values we got back are: \(value)")
                            let json = JSON(value)
//                            print(json["response"])
//                            print(json["response"])
                            guard let timesArray = json["response"].array else{
                                print("No times found")
                                return
                            }
                            print(timesArray)
                            for array in timesArray{
                                for (key, arrValue) in array {
//                                    print(key, arrValue)
                                    if key == "risetime"{
                                       print(key, arrValue)
                                        let date = Date(timeIntervalSince1970: arrValue.doubleValue)
                                        print(date)
                                        let stringDate = dateFormatter.string(from: date)
//                                        userTimesArray.append(stringDate)
                                        let userCityModel = CityModel()
                                        userCityModel.cityName = userTextCityInfo[0]
                                        userCityModel.cityState = userTextCityInfo[1]
                                        userCityModel.cityName = userTextCityInfo[0]
                                        userCityModel.cityState = userTextCityInfo[1]
                                        userCityModel.cityTime = stringDate
                                        self.cityDataInfo.append(userCityModel)
                                    }
                                }
                            }
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            self.performSegue(withIdentifier: "cityPredictSegue", sender: self.cityDataInfo)
                        case.failure(let error):
                            print(error)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                case.failure(let error):
                    print(error)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentLocSegue" {
            if let MapVC = segue.destination as? MapViewController{
                if let currentLocModel = sender as? LocationModel{
                    MapVC.currentIssLocModel = currentLocModel
                }
            }
        }
        else if segue.identifier == "cityPredictSegue" {
            if let CityVC = segue.destination as? CityDataViewController{
                if let cityModelArray = sender as? [CityModel]{
                    CityVC.userCityList = cityModelArray
                    cityDataInfo.removeAll()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cityField.text = ""
    }

}


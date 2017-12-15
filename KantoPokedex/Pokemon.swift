//
//  Pokemon.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/11/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    var name: String!
    var id: Int!
    var type: String!
    var description: String!
    var attack: String!
    var defense: String!
    var height: String!
    var weight: String!
    var nextEvText: String!
    var nextEvID: Int!
    var url: String!
    typealias completeDownload = () -> ()
    
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
        self.url = "http://pokeapi.co/api/v1/pokemon/\(self.id!)"
    }
    
    var pkname: String {
        guard let pokename = self.name else {
            return ""
        }
        return pokename
    }
    
    var pkid: Int {
        guard let pokeid = self.id else {
            return 1
        }
        return pokeid
    }
    
    var pktype: String {
        guard let poketype = self.type else{
            return ""
        }
        return poketype
    }
    
    var pkdescription: String {
        guard let pokedescription = self.description else {
            return ""
        }
        return pokedescription
    }
    
    var pkattack: String {
        guard let pokeattack = self.attack else{
            return ""
        }
        return pokeattack
    }
    
    var pkdefense: String {
        guard let pokedefense = self.defense else{
            return ""
        }
        return pokedefense
    }
    
    var pkheight: String {
        guard let pokeheight = self.height else {
            return ""
        }
        return pokeheight
    }
    
    var pkweight: String {
        guard let pokeweight = self.weight else{
            return ""
        }
        return pokeweight
    }
    
    var pknextEvText: String {
        guard let pokenextEvText = self.nextEvText else {
            return ""
        }
        return pokenextEvText
    }
    
    var pknextEvID: Int {
        guard let pokenextEvID = self.nextEvID else {
            return 0
        }
        return pokenextEvID
    }
    
    var pkurl: String {
        guard let pokeurl = self.url else {
            return ""
        }
        return pokeurl
    }
    
    func downloadPokeDetails(completion: @escaping completeDownload) {
//        Alamofire.request(self._pokemonURL, method: .get).validate().responseJSON { response in
//        Alamofire.request(self.url, method: .get, Parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
        print("In download function")
        Alamofire.request(self.url).responseJSON{ response in
            switch response.result {
            case .success(let value):
                print(" success in request: \(response.result)")
                print("Values we got back are: \(value)")
                let json = JSON(value)
                self.weight = json["weight"].stringValue
                self.height = json["height"].stringValue
                self.attack = json["attack"].stringValue
                self.defense = json["defense"].stringValue
                
                print(self.weight, self.height, self.attack, self.defense)
                
                let nextEvolutionPoke = json["evolutions"][0]["to"].stringValue
                
                if nextEvolutionPoke == "" {
                    self.nextEvText = "No Evolutions"
                } else {
                    self.nextEvText = "Next Evolution: \(nextEvolutionPoke)"
                    self.nextEvID = Int(json["evolutions"][0]["resource_uri"].stringValue.replacingOccurrences(of: "/api/v1/pokemon/", with: "").replacingOccurrences(of: "/", with: ""))
                }
                
                var jsonTypes = json["types"]
                if jsonTypes.count > 0 {
                    self.type = "\(jsonTypes[0]["name"].stringValue)"
                    
                    if jsonTypes.count > 1 {
                        for  i in 1..<jsonTypes.count {
                            let typeName = jsonTypes[i]["name"].stringValue
                            self.type! += "/\(typeName)"
                        }
                    }
                }
                
                if json["descriptions"].count > 0 {
                    let descriptionURL = "http://pokeapi.co\(json["descriptions"][0]["resource_uri"].stringValue)"
                    
                    Alamofire.request(descriptionURL, method: .get).responseJSON { response in
                        
                        self.description = JSON(response.result.value!)["description"].stringValue
                        completion()
                    }
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
        print("Out of download function")
    }
    
}

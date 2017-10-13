//
//  PokemonExtension.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/13/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation

extension Pokemon: PokemonProtocol{
    var nextPokeID: Int! {return self.pkid + 1}
    func deletePokemon() {} // optional pokemon protocol function
    func pokeDetails() -> String {
        let details: String = "The pokemon's name is \(name!). It is described as \(description!) with a weight of \(weight!) lbs and a height of \(height!). It is a \(type!) type pokemon and has an attack value of \(attack!) and defense value of \(defense!)."
        return details
    }
}

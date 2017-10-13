//
//  pokemonProtocol.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/12/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation


protocol PokemonProtocol {
   
    var name: String! {get}
    var id: Int! {get}
    var type: String! {get}
    var description: String! {get}
    var attack: String! {get}
    var defense: String! {get}
    var height: String! {get}
    var weight: String! {get}
    var nextEvText: String! {get}
    var nextEvID: Int! {get}
    var url: String! {get}
    
    func deletePokemon() //optional function
    func pokeDetails()->String
}


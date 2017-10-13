//
//  TableCell.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/11/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell{
    
    var pokemon: Pokemon!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configCell(pokemon: Pokemon){
        self.pokemon = pokemon
        infoLabel.text = self.pokemon.pkname
    }
}

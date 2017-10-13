//
//  PokePicViewController.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/12/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class PokePicViewController: UIViewController {
    
    @IBOutlet var selectedPokeFullImage: UIImageView!
    @IBOutlet var selectedPokeDetails: UILabel!
    
    var selectedPokePic: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PicView is Loaded")
        print(selectedPokePic.pkname, selectedPokePic.pkid)
        self.navigationItem.title = selectedPokePic.pkname
        selectedPokeFullImage.image = UIImage(named: "\(selectedPokePic.pkid)")
        selectedPokeDetails.text = selectedPokePic.pokeDetails()
    }
}

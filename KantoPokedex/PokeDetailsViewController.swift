//
//  PokeDetailsViewController.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/11/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class PokeDetailsViewController: UIViewController{
    
    @IBOutlet var selectedPokeImage: UIImageView!
    @IBOutlet var selectedPokeDescLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var attackLabel: UILabel!
    @IBOutlet var defenseLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var nextEvLabel: UILabel!
    @IBOutlet var nextEvButton: UIButton!
    @IBOutlet var basePokeImg: UIImageView!
    @IBOutlet var evPokeImg: UIImageView!
    
    
    
    var poke: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Details View Loaded.")
        print(poke.pkname, poke.pkid)
        self.navigationItem.title = poke.pkname
        selectedPokeImage.image = UIImage(named: "\(poke.pkid)")
        let singleTap = UITapGestureRecognizer(target:self, action: #selector(PokeDetailsViewController.tapDetected))
        singleTap.numberOfTapsRequired = 1
        selectedPokeImage.isUserInteractionEnabled = true
        selectedPokeImage.addGestureRecognizer(singleTap)
        initialView()
    }
    
    func tapDetected(){
        print("Tap deteced")
        var pokeChoice: Pokemon!
        pokeChoice = poke
        performSegue(withIdentifier: "ShowFullPokePic", sender: pokeChoice)
    }
    
    func initialView(){
        poke.downloadPokeDetails {
            self.updatePokeView()
        }
    }
    
    func updatePokeView(){
        selectedPokeDescLabel.text = poke.pkdescription
        typeLabel.text = "Type: \(poke.pktype)"
        attackLabel.text = "Attack: \(poke.pkattack)"
        defenseLabel.text = "Defense: \(poke.pkdefense)"
        idLabel.text = "DexID: \(poke.pkid)"
        heightLabel.text = "Height: \(poke.pkheight)"
        weightLabel.text = "Weight: \(poke.pkweight)"
        basePokeImg.image = UIImage(named: "\(poke.pkid)")
        if poke.pknextEvID != 0 {
            evPokeImg.image = UIImage(named: "\(poke.pknextEvID)")
        }else{
            evPokeImg.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFullPokePic" {
            if let pokePicVC = segue.destination as? PokePicViewController{
                if let choicePoke = sender as? Pokemon{
                    pokePicVC.selectedPokePic = choicePoke
                }
            }
        }
    }
}

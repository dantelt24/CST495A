//
//  ViewController.swift
//  KantoPokedex
//
//  Created by Dante  Lacey-Thompson on 10/11/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var backgrndImg: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Home view loaded")
        backgrndImg.image = UIImage(named: "whos_that_pokemon")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


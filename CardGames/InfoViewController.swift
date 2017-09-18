//
//  InfoViewController.swift
//  CardGames
//
//  Created by Dante  Lacey-Thompson on 9/18/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit
import ViewColorChanger

class InfoViewController: UIViewController{
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In Info View")
        let colView = ColorView()
        colView.setNeedsDisplay(self.view.bounds)
        self.view.addSubview(colView)
    }
    
}

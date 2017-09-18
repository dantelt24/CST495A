//
//  ViewController.swift
//  ViewColorChanger
//
//  Created by Dante  Lacey-Thompson on 9/17/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let colorView = ColorView(frame: self.view.bounds)
        self.view.addSubview(colorView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


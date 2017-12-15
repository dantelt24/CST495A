//
//  infoViewController.swift
//  MyToDo
//
//  Created by Dante  Lacey-Thompson on 12/14/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController{
    
    @IBOutlet weak var lowImage: UIImageView!
    @IBOutlet weak var medImage: UIImageView!
    @IBOutlet weak var highImage: UIImageView!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var medLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Info View Loaded")
        lowLabel.adjustsFontSizeToFitWidth = true
        medLabel.adjustsFontSizeToFitWidth = true
        highLabel.adjustsFontSizeToFitWidth = true
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lowImage.image = UIImage(named: "low")
        medImage.image = UIImage(named: "medium")
        highImage.image = UIImage(named: "high")
    }
    
    func viewTap(_ sender: UITapGestureRecognizer){
        print("View was tapped")
        self.dismiss(animated: true, completion: nil)
    }
}

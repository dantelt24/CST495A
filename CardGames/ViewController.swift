//
//  ViewController.swift
//  CardGames
//
//  Created by Dante  Lacey-Thompson on 9/6/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITabBarControllerDelegate {
    
    var cardFiles: [String] = []
    var cardImages: [String] = []
    
    func addImages()-> [String]{
        let path = Bundle.main.resourcePath! + "/cardpics"
        let fm = FileManager.default
        do {
            let filesFromBundle = try fm.contentsOfDirectory(atPath: path)
            print(filesFromBundle)
            return filesFromBundle
        } catch {
            let emptyDir: [String] = ["empty"]
            return emptyDir
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarController?.delegate = self
        print("Home view loaded.")
        cardFiles = addImages()
        print(cardFiles)
        print(cardFiles.count)
        for cardFile in cardFiles{
            let cardName = cardFile.replacingOccurrences(of: ".png", with: "")
            cardImages.append(cardName)
            print(cardName)
        }
        Deck.shared.cards = cardImages
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


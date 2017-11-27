//
//  SettingsViewController.swift
//  ISS_MapCheck
//
//  Created by Dante  Lacey-Thompson on 11/27/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var settingsInfoLabel: UILabel!
    @IBOutlet weak var settingsCityTextField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Settings View Controller")
        settingsCityTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        settingsCityTextField.text = ""
    }
    
    @IBAction func saveToSettings(){
        if(settingsCityTextField.text?.isEmpty ?? true){
            print("TextField is empty")
            return
        }
        else{
            print("textfield isn't empty")
            print(settingsCityTextField.text!)
            let defaults = UserDefaults.standard
//            defaults.set(settingsCityTextField.text, forKey: "userSettingCity")
            defaults.setValue(settingsCityTextField.text, forKey: "userSettingCity")
            performSegue(withIdentifier: "saveToMain", sender: self)
        }
    }
}

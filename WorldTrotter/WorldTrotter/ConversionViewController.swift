//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Dante  Lacey-Thompson on 9/1/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var farenheightValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var celsiusValue: Measurement<UnitTemperature>?{
        if let farenheightValue = farenheightValue{
            return farenheightValue.converted(to: .celsius)
        }else{
            return nil;
        }
    }
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue{
            //celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }else{
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            print("Current text: \(textField.text)")
//            print("Replacement text: \(string)")
//            return true
            let existingTextHasDecimalSeperator = textField.text?.range(of: ".")
            let replacementTextHasDecimalSeperator = string.range(of: ".")
        
            if existingTextHasDecimalSeperator != nil,
                replacementTextHasDecimalSeperator != nil{
                return false
            }else{
                return true
        }
    }
    
    @IBAction func disnmissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    @IBAction func farenheightFieldEditingChanged(_ textField: UITextField){
        //celsiusLabel.text = textField.text
//        if let text = textField.text, !text.isEmpty{
//            celsiusLabel.text = text
//        }else{
//            celsiusLabel.text = "???"
//        }
        if let text = textField.text, let value = Double(text){
            farenheightValue = Measurement(value: value, unit: .fahrenheit)
        }else{
            farenheightValue = nil
        }
    }
    
}

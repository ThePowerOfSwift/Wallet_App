//
//  Income_Delegate.swift
//  wallet
//
//  Created by Ammy Pandey on 18/04/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//Mark: Create class of CashTextField for nsobject and textfield delegate

class Income_Delegate: NSObject, UITextFieldDelegate{
    
    //Adopt method of UITextFieldDelegate is "ShouldChangeInCharachterInRange"
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // take constant to set charachter as NsString
        let oldText = textField.text! as NSString
        // take variable to replace constant to range and string
        var newText = oldText.replacingCharacters(in: range, with: string)
        //After Replacing the charachter insert it string as newtextstring variable
        var newTextString = String(newText)
        
        //Take a constant name digit and Charachterset to a decimal digit
        let newDigit = CharacterSet.decimalDigits
        
        //Take a new Variable as a Digit Text and leave blank
        
        var digitText = ""
        
        //Create For In loop for NewTextSring to use unicodeScalar value and put into newDigit
        for c in(newTextString?.unicodeScalars)!{
            if newDigit.contains(UnicodeScalar(c.value)!){
                digitText.append("\(c)")
            }
        }
        
        //Format the new string with if condition and new constant for A dollar sign field that begins with the text $0.00, and then fills in the dollar figure as digits are added.And take function of "dollarStringFromInt and centsStringFromInt
        if let beganWithRupeesSign = Int(digitText){
            newText = self.rupeesStringFromInt(beganWithRupeesSign) + "." + self.paiseStringFromInt(beganWithRupeesSign)
        }else{
            newText = "0.00"
        }
        textField.text = newText
        return false
    }
    //Adopt one more method of UITextFieldDelegate for set the empty text is "$0.00" and the method is "textFieldDidBeginEditing
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty)!{
            textField.text = "0.00"
        }
    }
    
    //Adopt a method to resgin Keyboard when user tapped on return key of keyboard and the method is "textFieldShouldReturn"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func rupeesStringFromInt(_ value: Int) -> String{
        return String(value / 100)
    }
    
    func paiseStringFromInt(_ value: Int) -> String{
        let cents = value % 100
        var centsString = String(cents)
        
        if cents < 10 {
            centsString = "0" + centsString
        }
        return centsString
    }
    
}

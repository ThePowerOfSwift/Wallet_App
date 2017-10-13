//
//  SignUpViewController.swift
//  wallet
//
//  Created by Ammy Pandey on 27/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Material
class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var fullNameTxt: TextField!
    @IBOutlet weak var userNameTxt: TextField!
    @IBOutlet weak var emailTxt: TextField!
    @IBOutlet weak var passwordTxt: TextField!
    @IBOutlet weak var confirmPasswordTxt: TextField!

    override func viewDidLoad() {
        super.viewDidLoad()
         //Mark: Keybard funtion call through Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.hideKeyboard()
    }
    //Mark: Resgin Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Mark: Hide keyborad when user touch arround
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    @IBAction func saveBtn(_ sender: RaisedButton) {
        //Mark: Save data
        if !((fullNameTxt.text?.isEmpty)!) && !((userNameTxt.text?.isEmpty)!) && !((passwordTxt.text?.isEmpty)!) && !((emailTxt.text?.isEmpty)!) && !((confirmPasswordTxt.text?.isEmpty)!) {
            
            if passwordTxt.text == confirmPasswordTxt.text{
            let isPasswordValid = isValidPassword(passwordString: passwordTxt.text!)
                if isPasswordValid{
                    print("Valid Password")
            let isEmailAddressValid = isValidEmailAddress(emailAddressString: emailTxt.text!)
            if isEmailAddressValid{
                print("Valid Email Address")
            
        let info: Database_Modal = Database_Modal()
        info.fullname = fullNameTxt.text!
        info.username = userNameTxt.text!
        info.email = emailTxt.text!
        info.password = passwordTxt.text!
        info.confirmPasswd = confirmPasswordTxt.text!
        
        let saveValue = Database_Manager.getInstance().insertUserManagmentData(info: info)
        if saveValue{
            let successAlert = UIAlertController(title: "Alert", message: "Successfully Registered", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){action in self.dismiss(animated: true, completion: nil)
            }
            successAlert.addAction(okAction)
            self.present(successAlert, animated: true, completion: nil)
            
            print("Data Save Successfully")
            
        }
        else{
            print("Data not saved")
            }
            }else{
                print("Not Valid Email Adress")
                displayAlertMessage(userMessage: "Email Address Not Valid")
            }
                }else{
                    displayAlertMessage(userMessage: "Password Must be 6 Charachter of alpha-numeric in both cases and a special charachter")
                }
            }else{
                displayAlertMessage(userMessage: "Password Not Match")
            }
            
        }else{
            displayAlertMessage(userMessage: "Please fill all the details")
        }

    }

    @IBAction func cancelBtn(_ sender: RaisedButton) {
        dismiss(animated: true, completion: nil)
    }
   //Mark: Display Alert Message
    func displayAlertMessage(userMessage: String){
        let alert = UIAlertController(title: "Alert!", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    //Mark: Email Address Validation
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnVAlue = true
        let emailRegx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegx)
            let nsString = emailAddressString as NSString
            let result = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if result.count == 0 {
                returnVAlue = false
            }
        }catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnVAlue = false
        }
        return returnVAlue
    }
    //Mark: Password Validation
    func isValidPassword(passwordString: String) -> Bool {
        var returnVAlue = true
        let passRegx = "((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20})"
        
        do {
            let regex = try NSRegularExpression(pattern: passRegx)
            let nsString = passwordString as NSString
            let result = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
            
            if result.count == 0 {
                returnVAlue = false
            }
        }catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnVAlue = false
        }
        return returnVAlue
    }

    //Mark: Keyboard function to step up screen when keyboard appear
    func keyboardWillShow(notification: NSNotification) {
        
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 50
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 50
            }
        }
        
    }

}


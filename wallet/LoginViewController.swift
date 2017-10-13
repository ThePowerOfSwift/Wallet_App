//
//  LoginViewController.swift
//  wallet
//
//  Created by Ammy Pandey on 27/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Material
class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userNameTxt: TextField!
    @IBOutlet weak var passTxt: TextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userArr: NSMutableArray = NSMutableArray()
   // var userid: Int = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Mark: Keybard funtion call through Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.hideKeyboard()

    }
    override func viewWillAppear(_ animated: Bool) {
        userNameTxt.text = ""
        passTxt.text = ""
    }
    //Mark: Resgin keybard when return key press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Mark: Resgin keybard when user tap outside from textfield
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    @IBAction func loginBtn(_ sender: RaisedButton) {
        
        var info: Database_Modal = Database_Modal()
        info.username = userNameTxt.text!
        info.password = passTxt.text!
        activityIndicator.startAnimating()
        if (userNameTxt.text?.isEmpty)!{
            displayAlertMessage(userMessage: "Please Enter Username")
        }else if (passTxt.text?.isEmpty)!{
            displayAlertMessage(userMessage: "Please Enter password")
        }
        if (info.username == userNameTxt.text) && (info.password == passTxt.text){
        userArr = Database_Manager.getInstance().fetchUserManagmentData(info: info)
        if userArr.count > 0 {
            info = userArr.object(at: 0) as! Database_Modal
            UserDefaults.standard.set(info.userId, forKey: "USER_ID")
            UserDefaults.standard.set(info.username, forKey: "userName")
            print(info.userId)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HOME") as? SWRevealViewController
            self.present(vc!, animated: true, completion: nil)
            print("User Exist")
        }else{
            activityIndicator.stopAnimating()
            displayAlertMessage(userMessage: "Please Enter Right Credential")
            viewWillAppear(true)
            print("User Not Exist")
            }
        }
    }
    //Mark: Keyboard function to step up screen when keyboard appear
    func keyboardWillShow(notification: NSNotification) {
        
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= 100
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += 100
            }
        }
        
    }
    //Mark: Display Alert Message
    func displayAlertMessage(userMessage: String){
        let alert = UIAlertController(title: "Alert!", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}

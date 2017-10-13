//
//  IncomeViewController.swift
//  wallet
//
//  Created by Ammy Pandey on 24/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit
import Material

class IncomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    @IBOutlet var uiview: UIView!
    @IBOutlet weak var amountTxt: TextField!
    @IBOutlet weak var categoryTxt: TextField!
    @IBOutlet weak var detailsTxt: TextField!
    @IBOutlet weak var dateTxt: TextField!
    let datePicker = UIDatePicker()
    let catPicker = UIPickerView()
    var my_id: Int = Int()
    var incomeSource = ["Salary", "Rent Received", "BankOfIntrest"]
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    //Set delegate of cashtextfield
    let incomeAmount = Income_Delegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegates Sets
        self.amountTxt.delegate = self.incomeAmount
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideKeyboard()
        
        catPicker.delegate = self
        catPicker.dataSource = self
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        createDatePicker()
        createPickerView()


    }
    override func viewWillAppear(_ animated: Bool) {
        dateTxt.text = ""
        amountTxt.text = ""
        categoryTxt.text = ""
        detailsTxt.text = ""
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
    //Mark: Function for date Picker
    func createDatePicker(){
        datePicker.datePickerMode = .date
        
        //Mark: Create toolBar
        let tool = UIToolbar()
        tool.sizeToFit()
        
        //Mark: Create Bar Button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        tool.setItems([doneBtn], animated: true)
        dateTxt.inputAccessoryView = tool
        dateTxt.inputView = datePicker
    }
    //Mark: Insert date in TextField 
    func donePressed(){
    //Mark: Convert date in string
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateTxt.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    //Mark: Methods of picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return incomeSource.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTxt.text = incomeSource[row]
        self.view.endEditing(false)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return incomeSource[row]
    }
    //Mark: Function for Picker View
    func createPickerView(){
        categoryTxt.inputView = catPicker
        
        //Mark: create toolbar to done when selected item
        let tool = UIToolbar()
        tool.sizeToFit()
        
        //Mark: done btn for done when seletcted
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        tool.setItems([doneBtn], animated: false)
        categoryTxt.inputAccessoryView = tool
    }
    //Mark: Done tapped Action
    func doneTapped(){
        self.view.endEditing(true)
    }
    @IBAction func saveBTn(_ sender: UIBarButtonItem) {
        if !((dateTxt.text?.isEmpty)!) && !((amountTxt.text?.isEmpty)!) && !((categoryTxt.text?.isEmpty)!) && !((detailsTxt.text?.isEmpty)!){
        
        let info: Database_Modal = Database_Modal()
        info.date = dateTxt.text!
        info.amount = Double(amountTxt.text!)!
        info.category = categoryTxt.text!
        info.detail = detailsTxt.text!
        info.status = "Income"
       info.id = UserDefaults.standard.integer(forKey: "USER_ID")
        //info.id = my_id
        print(info.id)
        
        let saveValue = Database_Manager.getInstance().insertPassbookData(info: info)
        if saveValue{
            print("Data Saved")
            displayAlertMessage(userMessage: "Entery Saved")
            viewWillAppear(true)
        }else{
            print("Data not Saved")
        }
        }else{
            displayAlertMessage(userMessage: "Please Fill all the details")
        }
    }
    //Mark: Display Alert Message
    func displayAlertMessage(userMessage: String){
        let alert = UIAlertController(title: "Alert!", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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

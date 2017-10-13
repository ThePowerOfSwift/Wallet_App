//
//  WalletViewController.swift
//  wallet
//
//  Created by Ammy Pandey on 22/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var imgArray = ["income.png", "expenses.png"]
    var passData: NSMutableArray!
    var totalInc: NSMutableArray!
    var totalExp: NSMutableArray!
    var walletBalance: Double = Double()
    var income: Double = Double()
    var expense: Double = Double()
    @IBOutlet weak var passTable: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        passTable.delegate = self
        passTable.dataSource = self
        menuBtn.target = self.revealViewController()
        menuBtn.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.totalOfIncome()
        self.totalOfExpenses()
        self.totalWalletBalance()
    }


    override func viewWillAppear(_ animated: Bool) {
        self.getAlldata()
       self.totalOfIncome()
        self.totalOfExpenses()
        self.totalWalletBalance()
    }
    
    func getAlldata(){
        passData = NSMutableArray()
        let info: Database_Modal = Database_Modal()
        info.id = UserDefaults.standard.integer(forKey: "USER_ID")
        passData = Database_Manager.getInstance().fetchPassbookData(info: info)
        passTable.reloadData()
    }
    //Mark: Table view delegate method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return passData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        let info:Database_Modal = passData.object(at: indexPath.row) as! Database_Modal
        info.id = UserDefaults.standard.integer(forKey: "USER_ID")
        cell.dateLbl.text = "\(info.date)"
        cell.categoryLbl.text = "\(info.category)"
        cell.detailLbl.text = "\(info.detail)"
        cell.amountLbl.text = "₹ \(info.amount)"
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let info: Database_Modal = passData.object(at: indexPath.row) as! Database_Modal
            
            
            
            let isDeleted = Database_Manager.getInstance().deleteDataFromPassbook(info: info)
            if isDeleted{
                let tv = tableView
                passData.remove(indexPath.row)
                tv.deleteRows(at: [indexPath], with: .fade)
            }
        }
        self.getAlldata()
    }
    //Mark: Total Income Sum
    func totalOfIncome(){
        totalInc = NSMutableArray()
        var info: Database_Modal = Database_Modal()
        let idStr=UserDefaults.standard.integer(forKey: "USER_ID")
        info.id = idStr
        totalInc = Database_Manager.getInstance().totalOfIncome(info: info)
        
        info = totalInc.object(at: 0) as! Database_Modal
        income = info.amount
        print(income)
        //print(info.amount)
        
    }
    //Matk: Total Expenses Sum
    func totalOfExpenses(){
        totalExp = NSMutableArray()
        var info: Database_Modal = Database_Modal()
        let idString = UserDefaults.standard.integer(forKey: "USER_ID")
        info.id = idString
        totalInc = Database_Manager.getInstance().totalOfExpenses(info: info)
        
        info = totalInc.object(at: 0) as! Database_Modal
        expense = info.amount
        print(expense)
        //print(info.amount)
        
    }
    
    func totalWalletBalance(){
    walletBalance = (income) - (expense)
        print(walletBalance)
        walletLbl.text = "Wallet Balance \n ₹  \(walletBalance)"
    }
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            getAlldata()
            passTable.reloadData()
        }
        if segment.selectedSegmentIndex == 1{
            let info: Database_Modal = Database_Modal()
            info.id = UserDefaults.standard.integer(forKey: "USER_ID")
            info.status = "Income"
            passData = Database_Manager.getInstance().fetchStatusData(info: info)
            passTable.reloadData()
        }
        if segment.selectedSegmentIndex == 2{
            let info: Database_Modal = Database_Modal()
            info.id = UserDefaults.standard.integer(forKey: "USER_ID")
            info.status = "Expenses"
            passData = Database_Manager.getInstance().fetchStatusData(info: info)
            passTable.reloadData()

        }
        
    }
}
    





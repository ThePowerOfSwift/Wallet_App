//
//  MenuViewController.swift
//  wallet
//
//  Created by Ammy Pandey on 24/03/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var userLbl: UILabel!
    
    @IBOutlet var uiview: UIView!
    @IBOutlet weak var imgSet: UIImageView!
    
    var imagePickerView = UIImagePickerController()
    var menuArray = [String]()
    var imgArray = ["home.png", "income.png", "expenses.png", "logout.png"]
    var userMsg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        uiview.backgroundColor = UIColor.uicolorFromHex(0xFF4081, alpha: 0.8)
        self.imagePickerView.delegate = self
        menuArray = ["Home", "Add Income", "Add Expenses", "LogOut"]
        userMsg = UserDefaults.standard.string(forKey: "userName")!
        userLbl.text = "Hi, \(userMsg.capitalized)!"
        userLbl.font = UIFont.preferredFont(forTextStyle: .callout)
        userLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.menuLbl.text = menuArray[indexPath.row]
        cell.imgTable.image = UIImage(named: imgArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController: SWRevealViewController = self.revealViewController()
        let cell: MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        if cell.menuLbl.text! == "Home" {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "WalletViewController") as! WalletViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.menuLbl.text! == "Add Income" {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "IncomeViewController") as! IncomeViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.menuLbl.text! == "Add Expenses" {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryBoard.instantiateViewController(withIdentifier: "ExpensesViewController") as! ExpensesViewController
            let newFrontViewController = UINavigationController.init(rootViewController:desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.menuLbl.text! == "LogOut" {
            let alert = UIAlertController(title: "LogOut", message: "Are You Sure To LogOut", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)}))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func imgOpenBtn(_ sender: UIButton) {
        imagePickerView.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        imagePickerView.allowsEditing = false
        self.present(imagePickerView, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgSet.contentMode = .scaleAspectFit
            imgSet.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


}

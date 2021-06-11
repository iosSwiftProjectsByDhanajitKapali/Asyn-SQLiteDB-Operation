//
//  ViewController.swift
//  Asyn SQLiteDB Operation
//
//  Created by unthinkable-mac-0025 on 11/06/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var testButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    var dbManager : SQLiteManager?
    var fliper = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveButton.layer.cornerRadius = 15.0
        deleteButton.layer.cornerRadius = 15.0
        
        
        dbManager = SQLiteManager()
        activityIndicator.isHidden = true
    }

    //Button to test UI Responsiveness
    @IBAction func testButtonPressed(_ sender: UIButton) {
        if(fliper){
            testButton.backgroundColor = UIColor.blue
            fliper = false
        }else{
            testButton.backgroundColor = UIColor.red
            fliper = true
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if let userName = nameTextField.text, !userName.isEmpty {
            //dispatch work item
            var dispatchWorkItem : DispatchWorkItem?
            dispatchWorkItem = DispatchWorkItem {
                self.insertData(userName)
            }
            dispatchWorkItem?.notify(queue: .main){
                print("Done executing WorkItem")
            }
            //dispatchWorkItem?.perform()
            let queue = DispatchQueue.global(qos: .utility)
            queue.async(execute: dispatchWorkItem!)
        }
    } //:saveButtonPressed
    
    func insertData(_ userName : String) {
        print("initiating insertion of users")
        DispatchQueue.main.async {
            self.saveButton.isEnabled = false
            self.deleteButton.isEnabled = false
            self.saveButton.setTitle("Saving...", for: .normal)
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
      
        for i in 1...1000{
            let name = "\(i)_\(userName)"
            dbManager?.insertDataToDB(name)
        }
        print("insertion of users complete")
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.saveButton.isEnabled = true
            self.deleteButton.isEnabled = true
            self.saveButton.setTitle("Save", for: .normal)
        }
        
    } //:insertData
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if let userName = nameTextField.text, !userName.isEmpty {
            //dispatch work item
            var dispatchWorkItem : DispatchWorkItem?
            dispatchWorkItem = DispatchWorkItem {
                self.deleteData(userName)
            }
            dispatchWorkItem?.notify(queue: .main){
                print("Done executing WorkItem")
            }
            //dispatchWorkItem?.perform()
            let queue = DispatchQueue.global(qos: .utility)
            queue.async(execute: dispatchWorkItem!)
        }
    } //:deleteButtonPressed
    
    func deleteData(_ userName : String)  {
        print("initiating deletion of users")
        DispatchQueue.main.async {
            self.deleteButton.isEnabled = false
            self.saveButton.isEnabled = false
            self.deleteButton.setTitle("Deleting...", for: .normal)
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        for i in 1...1000{
            let name = "\(i)_\(userName)"
            dbManager?.deleteDataFromDB(with: name)
        }
        print("deletion of users complete")
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.deleteButton.isEnabled = true
            self.saveButton.isEnabled = true
            self.deleteButton.setTitle("Delete", for: .normal)
        }
    } //:deleteData
    
   
}


//
//  SettingsViewController.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/24/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SettingsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var objects = [ObjectKind]()
    var currentSensors: String?
    var usersRef:DatabaseReference?
    var ref:DatabaseReference?
    var uid:String?
    var handle: DatabaseHandle?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "sunset_fly_blur.png")!)
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        self.objects.append(ObjectKind(type: "Sensors", belonging: ["Camera", "PH", "Turbidity"]))
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.layer.cornerRadius = 10.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame
        return objects.count
        
    }
    
    func roundedCorners(){
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects[section].belonging.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = objects[indexPath.section].belonging[indexPath.row]
        
        
        //here is programatically switch make to the table view
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        currentSensors = cell.textLabel?.text
        switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        cell.accessoryView = switchView
        return cell
    }
    
    @objc func switchChanged(sender: AnyObject) {
        let newFridgeRef = self.ref?.child("user").child("fridge")
        let Tswitch = sender as! UISwitch
        if Tswitch.tag == 0 {
            Tswitch.tag = 10
            let currentStatus = ["cameraStatus": 1]
            newFridgeRef?.updateChildValues(currentStatus)
        }
        
        else if Tswitch.tag == 1 {
            Tswitch.tag = 11
            let currentStatus = ["PHStatus": 1]
            newFridgeRef?.updateChildValues(currentStatus)
        }
        
        else if Tswitch.tag == 2 {
            Tswitch.tag = 12
            let currentStatus = ["turbStatus": 1]
            newFridgeRef?.updateChildValues(currentStatus)
        }
        
        else if Tswitch.tag == 10 {
            Tswitch.tag = 0
            let currentStatus = ["cameraStatus": 0]
            newFridgeRef?.updateChildValues(currentStatus)
        }
        
        else if Tswitch.tag == 11 {
            Tswitch.tag = 1
            let currentStatus = ["PHStatus": 0]
            newFridgeRef?.updateChildValues(currentStatus)
        }
        
        else if Tswitch.tag == 12 {
            Tswitch.tag = 2
            let currentStatus = ["turbStatus": 0]
            newFridgeRef?.updateChildValues(currentStatus)
        }
        
        print(Tswitch.tag)

        
    }
    
    func turnOnOff(){
        
        
    }
    
    
    
    // header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objects[section].type
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    

}





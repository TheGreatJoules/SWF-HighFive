//
//  HomeViewController.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/24/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SwiftChart

class HomeViewController: UIViewController {
    
    var isGraphDataViewShowing = true
    var imageView: UIImageView!
    var secondView: UIView!
    var chart: Chart!
    var waterLabel: UILabel!
    var phLabel: UILabel!
        var phValue: UILabel!
    var turbidityLabel: UILabel!
        var turbidityValue: UILabel!
    var changeLabel: UILabel!
    var dateLabel: UILabel!
    
    var usersRef:DatabaseReference?
    var ref:DatabaseReference?
    var uid:String?
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "red_purple_sky_blur.png")!)
        // SECOND VIEW
        secondView = UIImageView()
        secondView.backgroundColor = UIColor.lightGray
        self.secondView.layer.borderWidth = 3
        self.secondView.layer.borderColor = UIColor.black.cgColor
        secondView.isHidden = false
        bottomDisplay.addSubview(secondView)
        setupSecondAnchors()
        
        // CHART DISPLAY
        chart = Chart()
        setupChart.newChart(chart: chart)
        secondView.addSubview(chart)
        chart.isHidden = false
        setupChartAnchors()
        
        // WATER LABEL
        waterLabel = UILabel()
        setWater()
        secondView.addSubview(waterLabel)
        setupWaterLabelAnchors()

        // PH Label
        phLabel = UILabel()
        phValue = UILabel()
        setPH()
        secondView.addSubview(phLabel)
        secondView.addSubview(phValue)
        setupPHLableAnchor()
        setupPHValueLableAnchor()

        // TURBIDITY LABEL
        turbidityLabel = UILabel()
        turbidityValue = UILabel()
        setValuesForTable()
        secondView.addSubview(turbidityLabel)
        secondView.addSubview(turbidityValue)
        setupTurbidityLabelAnchor()
        setupTurbidityValueAnchor()
       
        // CHANGE FILTER
        changeLabel = UILabel()
        dateLabel = UILabel()
        setChangeTitle()
        secondView.addSubview(changeLabel)
        secondView.addSubview(dateLabel)
        setupChangeLabelAnchor()
        setupDateLabelAnchor()
        
        // IMAGE VIEW
        imageView = UIImageView()

        // DOUBLE TAP GESTURE
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        bottomDisplay.addGestureRecognizer(tap)
    
        hideText()
    }
    
    func setupDateLabelAnchor(){
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: turbidityLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: changeLabel.leadingAnchor, constant: 242).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: changeLabel.trailingAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    func setupChangeLabelAnchor(){
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.topAnchor.constraint(equalTo: turbidityLabel.bottomAnchor, constant: 10).isActive = true
        changeLabel.leadingAnchor.constraint(equalTo: waterLabel.leadingAnchor, constant: 10).isActive = true
        changeLabel.trailingAnchor.constraint(equalTo: turbidityLabel.trailingAnchor).isActive = true
        changeLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        changeLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    func setupTurbidityValueAnchor(){
        turbidityValue.translatesAutoresizingMaskIntoConstraints = false
        turbidityValue.topAnchor.constraint(equalTo: phLabel.bottomAnchor, constant: 10).isActive = true
        turbidityValue.leadingAnchor.constraint(equalTo: turbidityLabel.leadingAnchor, constant: 100).isActive = true
        turbidityValue.trailingAnchor.constraint(equalTo: turbidityLabel.trailingAnchor).isActive = true
        turbidityValue.widthAnchor.constraint(equalToConstant: 400).isActive = true
        turbidityValue.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupTurbidityLabelAnchor(){
        turbidityLabel.translatesAutoresizingMaskIntoConstraints = false
        turbidityLabel.topAnchor.constraint(equalTo: phLabel.bottomAnchor, constant: 10).isActive = true
        turbidityLabel.leadingAnchor.constraint(equalTo: phLabel.leadingAnchor).isActive = true
        turbidityLabel.trailingAnchor.constraint(equalTo: phLabel.trailingAnchor).isActive = true
        turbidityLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        turbidityLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupPHValueLableAnchor(){
        phValue.translatesAutoresizingMaskIntoConstraints = false
        phValue.topAnchor.constraint(equalTo: waterLabel.bottomAnchor, constant: 10).isActive = true
        phValue.leadingAnchor.constraint(equalTo: phLabel.leadingAnchor, constant: 100).isActive = true
        phValue.trailingAnchor.constraint(equalTo: phLabel.trailingAnchor).isActive = true
        phValue.widthAnchor.constraint(equalToConstant: 400).isActive = true
        phValue.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupPHLableAnchor(){
        phLabel.translatesAutoresizingMaskIntoConstraints = false
        phLabel.topAnchor.constraint(equalTo: waterLabel.bottomAnchor, constant: 10).isActive = true
        phLabel.leadingAnchor.constraint(equalTo: waterLabel.leadingAnchor, constant: 50).isActive = true
        phLabel.trailingAnchor.constraint(equalTo: waterLabel.trailingAnchor).isActive = true
        phLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        phLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupWaterLabelAnchors(){
        waterLabel.translatesAutoresizingMaskIntoConstraints = false
        waterLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant:20).isActive = true
        waterLabel.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 10).isActive = true
        waterLabel.trailingAnchor.constraint(equalTo: secondView.trailingAnchor, constant: -10).isActive = true
        waterLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        waterLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
    
    func setupChartAnchors(){
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.topAnchor.constraint(equalTo: bottomDisplay.topAnchor, constant: 20).isActive = true
        chart.leadingAnchor.constraint(equalTo: bottomDisplay.leadingAnchor, constant: 10).isActive = true
        chart.trailingAnchor.constraint(equalTo: bottomDisplay.trailingAnchor, constant: -10).isActive = true
        chart.widthAnchor.constraint(equalToConstant: 400).isActive = true
        chart.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupSecondAnchors(){
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.topAnchor.constraint(equalTo: bottomDisplay.topAnchor, constant: 20).isActive = true
        secondView.leadingAnchor.constraint(equalTo: bottomDisplay.leadingAnchor, constant: 10).isActive = true
        secondView.trailingAnchor.constraint(equalTo: bottomDisplay.trailingAnchor, constant: -10).isActive = true
        secondView.widthAnchor.constraint(equalToConstant: 400).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWater(){
        waterLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        waterLabel.textAlignment = .center
        waterLabel.text = "WATER Quality Test Completed!"
    }
    
    func setChangeTitle(){
        changeLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        let underlineAttribute = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Please change your filter on:", attributes: underlineAttribute)
        changeLabel.attributedText = underlineAttributedString

        
    }
    func setPH(){
        phLabel.font = UIFont.systemFont(ofSize: 16)
        phLabel.text = "PH Level: "
        waterLabel.textAlignment = .center
    }
    
    func setValuesForTable(){
        turbidityLabel.font = UIFont.systemFont(ofSize: 16)
        turbidityLabel.text = "Turbidity: "
        
        
        ref = Database.database().reference()
        uid = Auth.auth().currentUser?.uid
        usersRef = ref?.child("user").child("fridge")
        
        usersRef?.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                print("TURB DOESNT EXISIT")
                return
            }
            let postDict = snapshot.value as? [String: AnyObject]
            let statusTurb = postDict!["turbStatus"] as! Int
            let statuspH = postDict!["PHStatus"] as! Int
            
            if statusTurb == 1{
                // SET THE TURBIDITY
                let Turb_temp = postDict!["turb"] as! Double
                let Turb_new = Double(round(100*Turb_temp)/100)
                print(Turb_new)
                self.turbidityValue.font = UIFont.boldSystemFont(ofSize: 16)
                self.turbidityValue.textColor = UIColor.green
                self.turbidityValue.text = "\(Turb_new)%"
        
                
            } else if statusTurb == 0 {
                self.turbidityValue.font = UIFont.boldSystemFont(ofSize: 16)
                self.turbidityValue.textColor = UIColor.red
                self.turbidityValue.text = "unavailable"
            
            }
            if statuspH == 1 {
                // SET THE PH
                let PH_temp = postDict!["pH"] as! Double
                let PH_new = Double(round(100*PH_temp)/100)
                print(PH_new)
                self.phValue.font = UIFont.boldSystemFont(ofSize: 16)
                self.phValue.textColor = UIColor.green
                self.phValue.text = "\(PH_new)"
                
                // SET THE DATE
                let date_temp = postDict!["date"] as! String
                print(date_temp)
                self.dateLabel.font = UIFont.systemFont(ofSize: 16)
                self.dateLabel.textColor = UIColor.green
                self.dateLabel.text = date_temp
                
            } else if statusTurb == 0{
                self.phValue.font = UIFont.boldSystemFont(ofSize: 16)
                self.phValue.textColor = UIColor.red
                self.phValue.text = "unavailable"
                
                self.dateLabel.font = UIFont.systemFont(ofSize: 16)
                self.dateLabel.textColor = UIColor.red
                self.dateLabel.text = "unavailable"
            }
            
            
        }
    }
    
    func centerText(indent: CGFloat,inputX: CGFloat, inputY: CGFloat) -> CGRect{
        return CGRect(x: inputX, y: inputY, width: self.secondView.frame.width, height: self.secondView.frame.height / indent)
    }
    
    @IBAction func waterButton(_ sender: Any) {
        print("water pressed")
        self.chart.isHidden = true
        self.secondView.isHidden = false
        self.imageView.isHidden = true
        imageView.isHidden = true
        bottomDisplay.isUserInteractionEnabled = true
        chart.isHidden = false
        hideText()
        setValuesForTable()
        
    }
    func hideText(){
        waterLabel.isHidden = true
        phLabel.isHidden = true
        phValue.isHidden = true
        turbidityLabel.isHidden = true
        turbidityValue.isHidden = true
        changeLabel.isHidden = true
        dateLabel.isHidden = true
    }
    
    func displayText(){
        waterLabel.isHidden = false
        phLabel.isHidden = false
        phValue.isHidden = false
        turbidityLabel.isHidden = false
        turbidityValue.isHidden = false
        changeLabel.isHidden = false
        dateLabel.isHidden = false
    }
    
    @objc func doubleTapped() {
        print("DOUBLE TAP SUCCESS")
        setValuesForTable()
        perform(#selector(flip), with: nil, afterDelay: 0)
    }
    
    @objc func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
       
        if chart.isHidden == false {
            UIView.transition(with: chart, duration: 0.5, options: transitionOptions, animations: {
                self.chart.isHidden = true
            })
            
            UIView.transition(with: secondView, duration: 0.5, options: transitionOptions, animations: {
                //self.secondView.isHidden = false
                self.displayText()
            })
            //displayText()
        } else{
            UIView.transition(with: secondView, duration: 0.5, options: transitionOptions, animations: {
                //self.secondView.isHidden = true
                self.displayText()
            })
            
            UIView.transition(with: chart, duration: 0.5, options: transitionOptions, animations: {
                self.chart.isHidden = false
                self.hideText()
            })
        }
        //displayText()
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        print("camera pressed")
        
        // TEMP. SUSPEND DOUBLE TAP
        bottomDisplay.isUserInteractionEnabled = false
        self.chart.isHidden = true
        self.secondView.isHidden = true
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let usersRef = ref.child("user").child(uid!)

        usersRef.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                print("PROFILE DOESNT EXISIT")
                return
            }
            self.spinner.startAnimating()
            let userInfo = snapshot.value as! NSDictionary
            print(userInfo)
            print(userInfo["username"]!)
            let profileUrl = userInfo["profileImage"] as! String
            print(profileUrl)
            
            let usersRef2 = ref.child("user").child("fridge")
            
            usersRef2.observeSingleEvent(of: .value) { (snapshot) in
                if !snapshot.exists() {
                    return
                }
                let postDict = snapshot.value as? [String: AnyObject]
                let cameraStatus = postDict!["cameraStatus"] as! Int
                if cameraStatus == 1 {
                    self.imageView.image = nil
                    let storageRef = Storage.storage().reference(forURL: "gs://seniordesign-myfridge.appspot.com/fridge/updated pic")
                    // Download the data, assuming a max size of 1MB (you can change this as necessary)
                    storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
                        let downloadedImage = UIImage(data: data!)
                        print("IMAGE EXISIT")
                        self.imageView = UIImageView(image: downloadedImage!)
                        self.imageView.isHidden = false
                        
                        self.imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
                        self.imageView.contentMode = .scaleAspectFit // OR .scaleAspectFill
                        self.imageView.clipsToBounds = true
                        
                        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bottomDisplay.frame.width, height: self.bottomDisplay.frame.height)
                        
                        self.imageView.tag = 100
                        self.bottomDisplay.addSubview(self.imageView)
                        self.spinner.stopAnimating()
                        return
                    }
            
                    
                } else{
                    self.imageView.image = nil 
                    let downloadedImage = UIImage(named: "NoImageFound.png")
                    print("IMAGE DOES NOT EXISIT")
                    self.imageView = UIImageView(image: downloadedImage!)
                    self.imageView.isHidden = false
                    self.imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin]
                    self.imageView.contentMode = .scaleAspectFit // OR .scaleAspectFill
                    self.imageView.clipsToBounds = true
                    
                    self.imageView.frame = CGRect(x: self.bottomDisplay.frame.midX/2, y: self.bottomDisplay.frame.midY/8, width: self.bottomDisplay.frame.width/2, height: self.bottomDisplay.frame.height/2)
                    
                    self.imageView.tag = 100
                    self.bottomDisplay.addSubview(self.imageView)
                    self.spinner.stopAnimating()
                    return
                }
            }
        }
    }
    
    func removeSubview(){
        print("Start remove sibview")
        if let viewWithTag = self.bottomDisplay.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No!")
        }
    }
    
    
    
    @IBAction func tempButton(_ sender: Any) {
        print("temp pressed")
    }
    
    @IBOutlet weak var bottomDisplay: UIView!{
        didSet{
            bottomDisplay.backgroundColor = UIColor.clear
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleView: UIView!{
        didSet{
            self.titleView.backgroundColor = UIColor.clear
        }
    }
    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
        }catch let logoutError{
            print(logoutError)
        }
        let newFridgeRef = self.ref?.child("user").child("fridge")
        let cameraStatus = ["cameraStatus": 0]
        let phStatus = ["PHStatus": 0]
        let turbStatus = ["turbStatus": 0]
        
        newFridgeRef?.updateChildValues(cameraStatus)
        newFridgeRef?.updateChildValues(phStatus)
        newFridgeRef?.updateChildValues(turbStatus)
        
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let signinVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(signinVC, animated: true, completion: nil)
    }


}


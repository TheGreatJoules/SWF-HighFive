//
//  ProfileViewController.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/24/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var objects = [ObjectKind]()
    var usersRef:DatabaseReference?
    var ref:DatabaseReference?
    var uid:String?
    var handle: DatabaseHandle?
    
    var imageView: UIImageView!

    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "red_blue_soft_morning_blur.png")!)
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        uid = Auth.auth().currentUser?.uid
        usersRef = ref?.child("user").child(uid!)
        getProfileImage()
        fetchData()
//        self.objects.append(ObjectKind(type: "Birds", belonging: ["Bat", "Pigeon", "Crow", "Vulture"]))


    }
    


    func fetchData() {
        
        usersRef?.observeSingleEvent(of: .value, with: { (snapshot) in

            let postDict = snapshot.value as? [String: AnyObject]
            print(snapshot.childrenCount)
            //print(postDict)

            print("$$$ BEFORE START $$$")
            let emailData = postDict!["email"] as! String
            let usernameData = postDict!["username"] as! String
            print(emailData)
            print(usernameData)
            
            let userInfoArray = ["Username": [usernameData],"Email": [emailData]]


            for (key, value) in userInfoArray {
                print("\(key) -> \(value)")
                self.objects.append(ObjectKind(type: key, belonging: value ))

            }
            
            DispatchQueue.main.async(){
                self.tableView.reloadData()
            }
            

        })

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects[section].belonging.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = objects[indexPath.section].belonging[indexPath.row]
        return cell
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
    
    
    // Get profile image
    
    func getProfileImage (){
        
        self.usersRef = ref?.child("user").child(uid!)
        
        self.usersRef?.observeSingleEvent(of: .value) { (snapshot) in
            if !snapshot.exists() {
                print("PROFILE DOESNT EXISIT")
                return
            }
            //self.spinner.startAnimating()
            let userInfo = snapshot.value as! NSDictionary
            let profileUrl = userInfo["profileImage"] as! String
            let storageRef = Storage.storage().reference(forURL: profileUrl)
            // Download the data, assuming a max size of 1MB (you can change this as necessary)
            storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
                let downloadedImage = UIImage(data: data!)
                print("IMAGE EXISIT")
                self.profileImage.image = downloadedImage
                self.profileImage.contentMode = UIViewContentMode.scaleAspectFill

            }
            
        }
    }

}

struct ObjectKind {
    let type: String
    let belonging: [String]
}

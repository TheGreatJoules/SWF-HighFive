//
//  SignUpViewController.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/20/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController,UITextFieldDelegate {

    //var signupFirebase🔥 = myFirebase()
    var selectedImage: UIImage?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var signupButton: UIButton!{
        didSet{
            signupButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            signupButton.isEnabled = false
        }
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1){
            AuthSevice.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, imageData: imageData, onSuccess: {
                ProgressHUD.showSuccess("Success")
                self.performSegue(withIdentifier: "signupTabBarVC", sender: nil)
            }, onError: { (error) in
                ProgressHUD.showError(error!)
            })
        } else{
            ProgressHUD.showError("Profile Image can't be empty")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(SignUpViewController.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        handleTextField()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       self.view.endEditing(true)
    }
    
    func handleTextField(){
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldShouldChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldShouldChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldShouldChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldShouldChange(){
        guard   let username = usernameTextField.text, !username.isEmpty,
                let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty
                else {
                    signupButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
                    signupButton.isEnabled = false
                    return
        }
        signupButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signupButton.isEnabled = true
    }
    
    @objc func handleSelectProfileImageView (){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField{
            emailTextField.becomeFirstResponder()
        }
        
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }
            
        else if textField == passwordTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did Finish Picking Media")
        if let pickedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = pickedImage
            profileImage.image = pickedImage
            print("Complete")
        }
        
        dismiss(animated: true, completion: nil)
    }
}



//
//  LoginViewController.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/18/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    //var loginFirebase🔥 = myFirebase()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!{
        didSet{
            signinButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            signinButton.isEnabled = false
        }
    }
    
    @IBAction func signinButton(_ sender: UIButton) {
        ProgressHUD.show("Waiting...", interaction: false)
        AuthSevice.signIn(email: emailTextField.text!, password: passwordTextField.text!,onSuccess: {
            ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "signinTabBarVC", sender: nil)
        }, onError: { error in
            ProgressHUD.showError(error!)
        })
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        handleTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            self.performSegue(withIdentifier: "signinTabBarVC", sender: nil)
        }
    }
    
    func fetchUser(){
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func handleTextField(){
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldShouldChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldShouldChange), for: UIControlEvents.editingChanged)
    }
    
    @objc func textFieldShouldChange(){
        guard   let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty
            else {
                signinButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
                signinButton.isEnabled = false
                return
        }
        signinButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signinButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField{
            textField.resignFirstResponder()
        }
        return true
    }

}


//
//  AuthService.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 3/1/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthSevice{
    
    static func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {(user: User?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid!)
        
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    return
                }
                let profileImageUrl = metadata?.downloadURL()?.absoluteString
                self.setUserInformation(profileImageURL: profileImageUrl!, username: username, email: email, uid: uid!,onSuccess: onSuccess)
            })
            
        }
    }
    
    static func setUserInformation(profileImageURL: String, username: String, email: String, uid: String, onSuccess: @escaping() -> Void){
        let ref = Database.database().reference()
        let userReference = ref.child("user")
        let newUserReference = userReference.child(uid)
        newUserReference.setValue(["username": username,
                                   "email": email,
                                   "profileImage": profileImageURL])
        onSuccess()
        
    }
    

    
}

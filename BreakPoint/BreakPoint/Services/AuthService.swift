//
//  AuthService.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 14/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, imageCode: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user?.user else {
                userCreationComplete(false, error)
                
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email, "imageCoded": imageCode]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                loginComplete(false, error)
                return
            }
            
            loginComplete(true, nil)
        }
    }
}


//
//  AuthVC.swift
//  BreakPoint
//
//  Created by Jeffrey Umandap on 14/01/2019.
//  Copyright © 2019 Jeffrey Umandap. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {
    
    @IBOutlet weak var fbLoginBtn: UIButton!
    @IBOutlet weak var googleLoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func signInWithEmailButtonPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInButtonPressed(_ sender: Any) {
    }
    @IBAction func facebookSignInButtonPressed(_ sender: Any) {
    }
    
}

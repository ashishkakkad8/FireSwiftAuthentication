//
//  LoginVC.swift
//  FireSwiftAuthentication
//
//  Created by Ashish Kakkad on 09/04/17.
//  Copyright © 2017 Kode. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblCaution: UILabel!
    
    var handle: FIRAuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        handle = FIRAuth.auth()?.addStateDidChangeListener() { (auth, user) in
            print(auth)
            if let user = user {
                print(user)
                self.lblCaution.text = "😍\n Logged in with : \(user.email!)"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRAuth.auth()?.removeStateDidChangeListener(handle!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoginPressed(_ sender: Any) {
        self.view.endEditing(true)
        self.lblCaution.text = ""
        
        FIRAuth.auth()?.signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.lblCaution.text = "☹️\n\(error.localizedDescription)"
            }
            else if let user = user {
                print(user)
                self.lblCaution.text = "😍\n Logged in with : \(user.email!)"
            }
        }
    }
}


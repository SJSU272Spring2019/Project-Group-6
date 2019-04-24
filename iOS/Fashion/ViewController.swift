//
//  ViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/12/19.
//  Copyright © 20/Users/junlanlu/Library/Mobile Documents/com~apple~CloudDocs/ios_app/Project-Group-6/Frontend/Fashion/SettingsTableViewController.swift19 Junlan Lu. All rights reserved.
//

import UIKit
import FirebaseAuth
class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        // flip the botton
        isSignIn = !isSignIn;
        // check the bool and set the button and labels
        if isSignIn{
            signInLabel.text = "Sign In"
            signInButton.setTitle("sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
            
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        //check if it's sign in or register
        if let email = emailTextField.text, let pass = PasswordTextField.text{
            if isSignIn {
                //sign in the user with firebase
                Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                    if user != nil {
                        // user is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        // error: check error and show message
                    }
                }
            }
            else{
                    //Register the ser with Firebase
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if error != nil{
                        print (error?.localizedDescription) //print error
                    }
                    // check if user isn't nil
                    if user != nil{
                        // user is found. go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        // error: check error and show messagep
                        
                    }
                }
            }
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
    }
    
    
}


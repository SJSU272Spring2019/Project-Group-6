//
//  ViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/12/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        // flip the botton
        isSignIn = !isSignIn;
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
    }
}


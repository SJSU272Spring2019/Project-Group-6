//
//  SettingsTableViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/14/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//
import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // dismiss the keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }

}

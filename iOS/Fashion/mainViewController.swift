//
//  mainViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/20/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var dislikeLabel: UIButton!
    @IBOutlet weak var superlikeLabel: UIButton!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //scoreLabel.text = "34"
    
    @IBAction func dislikeTapped(_ sender: UIButton) {
    }
    

    @IBAction func superlikeTapped(_ sender: UIButton) {
    }
    
    @IBAction func likedTapped(_ sender: UIButton) {
    }
    

}

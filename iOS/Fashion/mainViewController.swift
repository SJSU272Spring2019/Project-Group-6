//
//  mainViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/20/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit

struct predictPic: Decodable{
    var clothId : String?
    var image : String?
    var price : String?
    var score : String?
}

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
        let jsonUrlString = "http://localhost:4000/v1/prediction"
        guard let url = URL(string: jsonUrlString) else { return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check error. reponse
            guard let data = data else {return}
            do {
                let myPredictPic = try JSONDecoder().decode(predictPic.self, from: data)
            }catch let jsonErr{ print ("error serialization json", jsonErr)}
            }.resume()
    }

    
    @IBAction func dislikeTapped(_ sender: UIButton) {
    }
    

    @IBAction func superlikeTapped(_ sender: UIButton) {
    }
    
    @IBAction func likedTapped(_ sender: UIButton) {
    }
}

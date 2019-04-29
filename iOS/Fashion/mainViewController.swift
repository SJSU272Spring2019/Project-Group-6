//
//  mainViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/20/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit
import FirebaseAuth

let userID = Auth.auth().currentUser!.uid
var clothID = "123" //default

struct PredictPic: Codable{
    var clothId : String?
    var url : String?
    var name : String?
    var price : String?
    var score : String?
}

struct PostChoice: Codable{
    var success: Bool?
}

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

class mainViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var dislikeLabel: UIButton!
    @IBOutlet weak var superlikeLabel: UIButton!
    @IBOutlet weak var likeLabel: UIButton!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var itemLabel: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPrediction(style:"Casual") { (success, predicted) in
           // guard let success = success else { return }
        }
    }
    
    func getPrediction(style:String, completion: @escaping (Bool?, PredictPic?) -> Void) {
        
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        myActivityIndicator.color = UIColor.black
        myActivityIndicator.backgroundColor = UIColor.gray
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        let jsonUrlString = "http://54.189.198.193:4000/v1/prediction"
        let url = URL(string: jsonUrlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = ["style" : style]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let session = URLSession.shared
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let data = data else {
                completion(false, nil)
                myActivityIndicator.stopAnimating()
                return
            }
            let predicted = try? JSONDecoder().decode(PredictPic.self, from: data)
            print (predicted as Any)
            if let url = predicted?.url {
                DispatchQueue.main.async {
                    self.imageLabel?.image = UIImage(url : URL(string: url))
                    self.scoreLabel?.text = predicted?.score
                    self.priceLabel?.text = predicted?.price
                    self.itemLabel?.text = predicted?.name
                }
            }
            clothID = ((predicted?.clothId!)!)
            
            DispatchQueue.main.async {
                myActivityIndicator.stopAnimating()
            }
            completion(true, predicted)
        }
        task.resume()
        view.addSubview(myActivityIndicator)
    }
    
    func postAddCart (userId: String, clothId: String, completion: @escaping (Bool?, PostChoice?) -> Void){
        let jsonUrlString = "http://54.189.198.193:4000/v1/addCart"
        let url = URL(string: jsonUrlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = ["userId": userId, "clothId": clothId]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let session = URLSession.shared
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let data = data else {
                completion(false, nil)
                return
            }
            let added = try? JSONDecoder().decode(PostChoice.self, from: data)
             print(added as Any)
            completion(true, added)
        }
        task.resume()
    }
    
    func postAddLike (userId: String, clothId: String, completion: @escaping (Bool?, PostChoice?) -> Void){
        let jsonUrlString = "http://54.189.198.193:4000/v1/addLike"
        let url = URL(string: jsonUrlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = ["userId": userId, "clothId": clothId]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let session = URLSession.shared
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let data = data else {
                completion(false, nil)
                return
            }
            let added = try? JSONDecoder().decode(PostChoice.self, from: data)
            print(added as Any)
            completion(true, added)
        }
        task.resume()
    }
    
    @IBAction func dislikeTapped(_ sender: UIButton) {
        // no need to POST
        // get prediction
        getPrediction(style:"Formal") { (success, predicted) in
        }
    }

    @IBAction func superlikeTapped(_ sender: UIButton) {
        // post userID and clothID
        let ID_cloth = clothID
        let ID_user = userID
        postAddCart (userId: ID_user, clothId: ID_cloth){(success, added)in
            
        }
        // get prediction
        getPrediction(style:"Formal") { (success, predicted) in
        }
    }
    
    @IBAction func likedTapped(_ sender: UIButton) {
        // post userID and clothID
        let ID_cloth = clothID
        let ID_user = userID
        postAddLike (userId: ID_user, clothId: ID_cloth){(success, added)in
            
        }
        
        getPrediction(style:"Formal") { (success, predicted) in

        }
    }
}

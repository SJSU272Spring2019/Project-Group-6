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
var clothFIndex = 0
var clothCIndex = 0

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
        getPrediction() { (success, predicted) in
           // guard let success = success else { return }
        }
        
        likeLabel.clipsToBounds = false
        likeLabel.layer.shadowColor = UIColor.lightGray.cgColor
        likeLabel.layer.shadowOpacity = 1
        likeLabel.layer.shadowOffset = CGSize.zero
        likeLabel.layer.shadowRadius = 2
        
        superlikeLabel.clipsToBounds = false
        superlikeLabel.layer.shadowColor = UIColor.lightGray.cgColor
        superlikeLabel.layer.shadowOpacity = 1
        superlikeLabel.layer.shadowOffset = CGSize.zero
        superlikeLabel.layer.shadowRadius = 2
        
        dislikeLabel.clipsToBounds = false
        dislikeLabel.layer.shadowColor = UIColor.lightGray.cgColor
        dislikeLabel.layer.shadowOpacity = 1
        dislikeLabel.layer.shadowOffset = CGSize.zero
        dislikeLabel.layer.shadowRadius = 2
        
        // UIImage
//        let outerView = imageLabel
        imageLabel.layer.roundCorners(radius: 20)
        imageLabel.layer.addShadow()
        
//        imageLabel.layer.insertSublayer(shadowLayer, at: 1)
        
//        let myImage = UIImageView(frame: outerView!.bounds)
//        myImage.clipsToBounds = true
//        myImage.layer.cornerRadius = 20
//        myImage.layer.borderColor = UIColor.white.cgColor
//        outerView?.addSubview(myImage)
        
        //gradient
        self.imageLabel.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let shadow = UIColor.black.withAlphaComponent(0.6).cgColor
        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: 405, width: 355, height: 150)
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        imageLabel.layer.insertSublayer(bottomImageGradient, at: 0)
        

      
    }
    
    func getPrediction(completion: @escaping (Bool?, PredictPic?) -> Void) {
        let style = UserDefaults.standard.string(forKey: "style") ?? "Formal"
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
        // hardcode cloth id
        var clothIndex = 0
        
        if (style == "Formal") {clothIndex = clothFIndex}else {clothIndex = clothCIndex}
        
        let parameters: [String: Any] = ["style" : style, "clothIndex" : clothIndex]
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
            // hard increase clothIndex
            if (style == "Formal") {clothFIndex = clothFIndex + 1} else {clothCIndex = clothCIndex + 1}
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
        sender.pulsate()
        // no need to POST
        // get prediction
        getPrediction() { (success, predicted) in
        }
    }

    @IBAction func superlikeTapped(_ sender: UIButton) {
        sender.pulsate()
        // post userID and clothID
        let ID_cloth = clothID
        let ID_user = userID
        print (ID_user)
        print (ID_cloth)
        postAddCart (userId: ID_user, clothId: ID_cloth){(success, added)in
            
        }
        // get prediction
        getPrediction() { (success, predicted) in
        }
    }
    
    @IBAction func likedTapped(_ sender: UIButton) {
        sender.pulsate()
        // post userID and clothID
        let ID_cloth = clothID
        let ID_user = userID
        postAddLike (userId: ID_user, clothId: ID_cloth){(success, added)in
        }
        getPrediction() { (success, predicted) in
        }
    }
}

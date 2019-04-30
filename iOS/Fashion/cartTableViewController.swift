//
//  cartTableViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/23/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit

struct MyCart: Codable{
    var clothId : String?
    var url : String?
    var name : String?
    var price : String?
    var score : String?
}
class cartTableViewController: UITableViewController {

    var cart = [MyCart]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getCartList(){ (success, List) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func getCartList (completion: @escaping (Bool?, MyCart?) -> Void){
        let jsonUrlString = "http://54.189.198.193:4000/v1/userCart"
        let url = URL(string: jsonUrlString)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = ["userId" : userID]
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let session = URLSession.shared
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            guard let data = data else {
                completion(false, nil)
                return
            }
            self.cart = try! JSONDecoder().decode([MyCart].self, from: data)
            print (self.cart)
            completion(true, nil)
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? wishListTableViewCell else { return UITableViewCell() }
        let vals = self.cart[indexPath.row]
        cell.scoreLabel?.text = vals.score
        cell.titleLabel?.text = vals.name
        cell.priceLabel?.text = vals.price
        cell.imageLabel?.image = UIImage(url : URL(string: vals.url!))
        return cell
    }
}

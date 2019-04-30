//
//  wishListTableViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/21/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit
import FirebaseAuth



struct MyList: Codable{
    var clothId : String?
    var url : String?
    var name : String?
    var price : String?
    var score : String?
}


class wishListTableViewController: UITableViewController {
    var list = [MyList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getWishList(){ (success, List) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func getWishList (completion: @escaping (Bool?, MyList?) -> Void){
        let jsonUrlString = "http://54.189.198.193:4000/v1/userLike"
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
            self.list = try! JSONDecoder().decode([MyList].self, from: data)
            print (self.list)
            completion(true, nil)
        }
        task.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? wishListTableViewCell else { return UITableViewCell() }
        let val = self.list[indexPath.row]
        cell.scoreLabel?.text = val.score
        cell.titleLabel?.text = val.name
        cell.priceLabel?.text = val.price
        cell.imageLabel?.image = UIImage(url : URL(string: val.url!))
        return cell
    }
}

//
//  cartTableViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/23/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit

class cartTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonUrlString = "http://localhost:4000/v1/addLike"
        guard let url = URL(string: jsonUrlString) else { return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check error. reponse
            guard let data = data else {return}
            do {
                let myCartList = try JSONDecoder().decode([cartList].self, from: data)
                //print (myCartList)
            }catch let jsonErr{print ("error serialization json", jsonErr)}
        }.resume()
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
//    var myCartList:[cartList] = [
//        cartList(id: "2", mainImage: "FRAYED EDGE JACKET", title: "FRAYED EDGE JACKET", price: "45 USD", score: "0.5"),
//        cartList(id: "3", mainImage: "TIED ASYMMETRIC TOP", title: "TIED ASYMMETRIC TOP", price: "49 USD", score: "0.6")
//    ]
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCartList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? cartTableViewCell else { return UITableViewCell() }
        
        let List = myCartList[indexPath.row]
        cell.scoreLabel?.text = List.score
        cell.titleLabel?.text = List.title
        cell.priceLabel?.text = List.price
        cell.imageLabel?.image = UIImage(named: List.mainImage!)
        
        return cell
    }
}

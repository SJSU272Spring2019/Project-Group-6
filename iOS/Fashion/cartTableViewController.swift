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
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    var myCart:[wishList] = [
        wishList(id: "2", mainImage: "FRAYED EDGE JACKET", title: "FRAYED EDGE JACKET", price: "45 USD", score: "0.5"),
        wishList(id: "3", mainImage: "TIED ASYMMETRIC TOP", title: "TIED ASYMMETRIC TOP", price: "49 USD", score: "0.6")
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCart.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? cartTableViewCell else { return UITableViewCell() }
        
        let List = myCart[indexPath.row]
        cell.scoreLabel?.text = List.score
        cell.titleLabel?.text = List.title
        cell.priceLabel?.text = List.price
        cell.imageLabel?.image = UIImage(named: List.mainImage!)
        
        return cell
    }
}

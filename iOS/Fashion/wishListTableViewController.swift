//
//  wishListTableViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/21/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit

class wishListTableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.register(wishListTableViewCell.self, forCellReuseIdentifier: "itemCell")

        self.tableView.reloadData()
    }

    var myWishList:[List] = [
        List(id: "1", mainImage: "Dress", title: "Dress", price: "76 USD", score: "0.1"),
        List(id: "2", mainImage: "FRAYED EDGE JACKET", title: "FRAYED EDGE JACKET", price: "45 USD", score: "0.5"),
        List(id: "3", mainImage: "TIED ASYMMETRIC TOP", title: "TIED ASYMMETRIC TOP", price: "49 USD", score: "0.6")
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myWishList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? wishListTableViewCell else { return UITableViewCell() }

        let List = myWishList[indexPath.row]
        cell.scoreLabel?.text = List.score
        cell.titleLabel?.text = List.title
        cell.priceLabel?.text = List.price
        cell.imageLabel?.image = UIImage(named: List.mainImage!)
        
        return cell
    }
}

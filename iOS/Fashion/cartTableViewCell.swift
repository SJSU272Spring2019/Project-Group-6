//
//  cartTableViewCell.swift
//  Fashion
//
//  Created by Junlan Lu on 4/23/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import Foundation
import UIKit

struct wishList{
    var id : String?
    var mainImage : String?
    var title : String?
    var price : String?
    var score : String?
}

class cartTableViewCell: UITableViewCell {

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var scoreLabel: UITextField!
    

}

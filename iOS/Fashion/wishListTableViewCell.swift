//
//  wishListTableViewCell.swift
//  Fashion
//
//  Created by Junlan Lu on 4/20/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import Foundation
import UIKit

struct List: Decodable{
    var clothId : String?
    var url : String?
    var name : String?
    var price : String?
    var score : String?
}

class wishListTableViewCell: UITableViewCell {
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var scoreLabel: UITextField!
}

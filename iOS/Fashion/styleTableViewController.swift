//
//  ethnicityTableViewController.swift
//  Fashion
//
//  Created by Junlan Lu on 4/18/19.
//  Copyright © 2019 Junlan Lu. All rights reserved.
//

import UIKit


class styleTableViewController: UITableViewController {
    
    @IBOutlet weak var formalCell: UITableViewCell!
    @IBOutlet weak var casualCell: UITableViewCell!
    @IBOutlet weak var sportsCell: UITableViewCell!
    @IBOutlet weak var vacationCell: UITableViewCell!
    
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let style = defaults.object(forKey: "style") as? String
        self.formalCell.accessoryType = .none
        self.casualCell.accessoryType = .none
        self.sportsCell.accessoryType = .none
        self.vacationCell.accessoryType = .none
        if style == "Formal" {
            self.formalCell.accessoryType = .checkmark
            // call POST style API
            //FashionAPI().postStyleInfo(style: "Asian")
        }else if style == "Casual"{
            self.casualCell.accessoryType = .checkmark
        }else if style == "Sports"{
            self.sportsCell.accessoryType = .checkmark
        }else if style == "Vacation"{
            self.vacationCell.accessoryType = .checkmark
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        self.formalCell.accessoryType = .none
        self.casualCell.accessoryType = .none
        self.sportsCell.accessoryType = .none
        self.vacationCell.accessoryType = .none
        if indexPath.row == 0{
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            self.formalCell.accessoryType = .checkmark
            self.defaults.set("Formal", forKey: "style")
            
        }else if indexPath.row == 1{
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            self.casualCell.accessoryType = .checkmark
            self.defaults.set("Casual", forKey: "style")
        }else if indexPath.row == 2{
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            self.sportsCell.accessoryType = .checkmark
            self.defaults.set("Sports", forKey: "style")
        }else if indexPath.row == 3{
            tableView.deselectRow(at: indexPath as IndexPath, animated: false)
            self.vacationCell.accessoryType = .checkmark
            self.defaults.set("Vacation", forKey: "style")
        }
    }
}


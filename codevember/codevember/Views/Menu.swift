//
//  Menu.swift
//  codevember
//
//  Created by Renan Germano on 03/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

class Menu: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool { true }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Day \(indexPath.row + 1)"
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let view = Day1View()
            self.navigationController?.pushViewController(view, animated: true)
            return
        }
        
        if let defaultView = self.storyboard?.instantiateViewController(identifier: "DefaultView") as? DefaultView {
            defaultView.titleText = "Day \(indexPath.row + 1)"
            self.navigationController?.pushViewController(defaultView, animated: true)
        }
        
    }

}

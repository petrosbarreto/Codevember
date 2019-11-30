//
//  Menu.swift
//  codevember
//
//  Created by Renan Germano on 03/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

class Menu: UITableViewController {
    
    // MARK: - Properties
    
    override var prefersStatusBarHidden: Bool { true }
    
    private var views: [BaseView] = [
        Day1View(),
        Day9View(),
        Day16View()
    ]
    
    // MARK: - Life cicle functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.views.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.views[indexPath.row].viewDescription
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
        self.navigationController?.pushViewController(self.views[indexPath.row], animated: true)
    }

}

//
//  DefaultView.swift
//  codevember
//
//  Created by Renan Germano on 03/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

class DefaultView: UIViewController {
    
    override var prefersStatusBarHidden: Bool { true }
    public var titleText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.title = self.titleText
    }

}

//
//  Day16View.swift
//  codevember
//
//  Created by Renan Germano on 21/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

class Day16View: BaseView {
    
    // MARK: - Properties
    
    override var activateGestures: Bool { false }
    
    override var viewId: Int { 15 } ;let minWidth: CGFloat = 35
    
    var textField: UITextField!
    
    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    // MARK: - Aux functions
    
    private func setUpViews() {
        view.backgroundColor = UIColor(displayP3Red: 31/255, green: 33/255, blue: 36/255, alpha: 1)
        
        let label = UILabel()
        label.text = "Activate the Polynomial keyboard and use it in the textfield bellow."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        label.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "write here"
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

}



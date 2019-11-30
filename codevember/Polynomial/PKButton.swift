//
//  PKButton.swift
//  Polinomial
//
//  Created by Renan Germano on 30/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol PKButtonDelegate {
    func pkButtonDelegateDidPress(pkButton: PKButton)
}

class PKButton: UIView {
    
    // MARK: - Constants
    
    private var kNormalColor: UIColor = .black
    private var kDisabledColor: UIColor = .darkGray
    private let kSelectedColor: UIColor = .red
    private let kChangingColor: UIColor = .green
    
    // MARK: - Properties
    
    private(set) var key: Key
    
    var delegate: PKButtonDelegate?
    
    private var unknownLabel: UILabel!
    private var degreeLabel: UILabel? = nil
    
    // MARK: - State control variables
    
    var selectingUnknowValue: Bool = false {
        didSet {
            
        }
    }
    
    var selectionDegreeValue: Bool = false {
        didSet {
            
        }
    }
    
    // MARK: - Initializers
    
    init(key: Key) {
        self.key = key
        
        super.init(frame: .zero)
        
        layer.borderWidth = 1
        layer.borderColor = kNormalColor.cgColor
        layer.cornerRadius = 4
        
        let stack = UIStackView()
        stack.spacing = 0
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.backgroundColor = .white
        
        unknownLabel = UILabel()
        unknownLabel.text = key.unknown ?? key.rawValue
        unknownLabel.font = UIFont.systemFont(ofSize: 24)
        unknownLabel.textAlignment = .center
        unknownLabel.sizeToFit()
        unknownLabel.textColor = kNormalColor
        stack.addArrangedSubview(unknownLabel)
        
        if let degree = key.degree {
            degreeLabel = UILabel()
            degreeLabel?.text = degree
            degreeLabel?.font = UIFont.systemFont(ofSize: 12)
            degreeLabel?.textAlignment = .center
            degreeLabel?.sizeToFit()
            degreeLabel?.textColor = kNormalColor
            stack.addArrangedSubview(degreeLabel!)
            stack.alignment = .top
        }
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: topAnchor, constant: 1).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        stack.sizeToFit()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressButton)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - GestureRecognizer functions
    
    @objc private func didPressButton() {
        delegate?.pkButtonDelegateDidPress(pkButton: self)
    }
    
}

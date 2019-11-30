//
//  KeyboardViewController.swift
//  Polinomial
//
//  Created by Renan Germano on 30/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, PKButtonDelegate {
    
    // MARK: - Properties
    
    /*
    1    2    3    +    x      undo
    4    5    6    -    x^2    clear
    7    8    9    *    x^3    (    )
    ,    0    .    /    x^n    enter
    */
    static var layout: [[Key]] {
        return [ [._1, ._2, ._3, .sum, .x, .undo],
                 [._4, ._5, ._6, .sub, .xpow2, .leftParenthesis, .rightParenthesis],
                 [._7, ._8, ._9, .mult, .xpow3, .pow],
                 [.comma, ._0, .dot, .div, .equals, .enter] ]
    }
    
    private let spacing: CGFloat = 4.0
    private var buttonSize: CGFloat = 0
    
    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        defineBestButtonSize()
        setUpKeyboardViews()
    }
    
    
    // MARK: - PKButtonDelegate funcitons
    
    func pkButtonDelegateDidPress(pkButton: PKButton) {
        if pkButton.key == .undo {
            textDocumentProxy.deleteBackward()
            return
        }
        if pkButton.key == .finish {
            
            return
        }
        if pkButton.key == .enter {
            
            return
        }
        textDocumentProxy.insertText(pkButton.key.writableValue)
    }
    
    // MARK: - Aux functions
    
    private func defineBestButtonSize() {
        guard !KeyboardViewController.layout.isEmpty,
              let viewWidth = parent?.view.frame.size.width else {
                return
        }
        var maxAmountOfButtonsPerLine: Int = KeyboardViewController.layout.first!.count
        for i in 1..<KeyboardViewController.layout.count {
            maxAmountOfButtonsPerLine = KeyboardViewController.layout[i].count > maxAmountOfButtonsPerLine ? KeyboardViewController.layout[i].count : maxAmountOfButtonsPerLine
        }
        buttonSize = viewWidth
        buttonSize -= (2 * spacing)
        buttonSize -= (CGFloat(maxAmountOfButtonsPerLine - 1) * spacing)
        buttonSize = buttonSize/CGFloat(maxAmountOfButtonsPerLine)
    }
    
    private func setUpKeyboardViews() {
        
        var keyboardLines: [UIStackView] = []
        
        for line in KeyboardViewController.layout {
            let keyboardLine = UIStackView()
            keyboardLine.axis = .horizontal
            keyboardLine.spacing = 4
            keyboardLine.distribution = .equalSpacing
            keyboardLine.alignment = .fill
            for key in line {
                let button = PKButton(key: key)
                button.delegate = self
                keyboardLine.addArrangedSubview(button)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
                button.widthAnchor.constraint(equalToConstant: key.isControlKey ? (buttonSize * 2) + (spacing * 3) : buttonSize).isActive = true
            }
            keyboardLines.append(keyboardLine)
        }
        
        let keyboard = UIStackView(arrangedSubviews: keyboardLines)
        keyboard.axis = .vertical
        keyboard.spacing = spacing
        keyboard.distribution = .fillEqually
        keyboard.alignment = .fill
        
        view.addSubview(keyboard)
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        keyboard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: spacing).isActive = true
        keyboard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -spacing).isActive = true
        keyboard.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing).isActive = true
        keyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing).isActive = true
        
        /*
         var buttons: [UIView] = []
        Key.all.forEach {
            let pkButton = PKButton(key: $0)
            pkButton.delegate = self
            buttons.append(pkButton)
        }
        
        let keyboard = UIStackView(arrangedSubviews: buttons)
        keyboard.spacing = 4
        keyboard.axis = .horizontal
        keyboard.alignment = .center
        keyboard.distribution = .equalSpacing
        
        view.addSubview(keyboard)
        keyboard.translatesAutoresizingMaskIntoConstraints = false
        keyboard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        keyboard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        keyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
        keyboard.heightAnchor.constraint(equalToConstant: 44).isActive = true
         */
    }
    
}

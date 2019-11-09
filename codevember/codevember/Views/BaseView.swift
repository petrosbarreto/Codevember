//
//  BaseView.swift
//  codevember
//
//  Created by Renan Germano on 03/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

protocol BaseViewInteractionDelegate {
    func didTap()
    func didSwipeLeft()
    func didSwipeRight()
    func didSwipeUp()
    func didSwipeDown()
}

class BaseView: UIViewController {
    
    // MARK: - Properties
    
    var interactionMessage: String? { return nil }
    
    override var prefersStatusBarHidden: Bool { true }
    
    // MARK: - Life cicle functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = .black
        DispatchQueue.main.async {
            self.setUp()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let message = self.interactionMessage {
            let alert = UIAlertController(title: "Interactino", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Set up functions
    
    private func setUp() {
        
        let gesturesView = UIView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        gesturesView.addGestureRecognizer(tapGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeLeft))
        leftSwipeGesture.direction = .left
        gesturesView.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeRight))
        rightSwipeGesture.direction = .right
        gesturesView.addGestureRecognizer(rightSwipeGesture)
        
        let upSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeUp))
        upSwipeGesture.direction = .up
        gesturesView.addGestureRecognizer(upSwipeGesture)
        
        let downSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipeDown))
        downSwipeGesture.direction = .down
        gesturesView.addGestureRecognizer(downSwipeGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.didLongPress))
        gesturesView.addGestureRecognizer(longPressGesture)
        
        gesturesView.backgroundColor = .clear
        
        self.view.addSubview(gesturesView)
        gesturesView.translatesAutoresizingMaskIntoConstraints = false
        gesturesView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        gesturesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        gesturesView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        gesturesView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
    }
    
    // MARK: - Gesture Recognizer functions
    
    @IBAction private func didTap() {
        if let delegate = self as? BaseViewInteractionDelegate {
            delegate.didTap()
        }
    }
    
    @IBAction private func didSwipeLeft() {
        if let delegate = self as? BaseViewInteractionDelegate {
            delegate.didSwipeLeft()
        }
    }
    
    @IBAction private func didSwipeRight() {
        if let delegate = self as? BaseViewInteractionDelegate {
            delegate.didSwipeRight()
        }
    }
    
    @IBAction private func didSwipeUp() {
        if let delegate = self as? BaseViewInteractionDelegate {
            delegate.didSwipeUp()
        }
    }
    
    @IBAction private func didSwipeDown() {
        if let delegate = self as? BaseViewInteractionDelegate {
            delegate.didSwipeDown()
        }
    }
    
    @IBAction private func didLongPress() {
        let alert = UIAlertController(title: "Finish", message: "Finish and go back to menu?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }

}

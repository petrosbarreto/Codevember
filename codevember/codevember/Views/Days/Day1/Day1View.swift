//
//  Day1ViewController.swift
//  codevember
//
//  Created by Renan Germano on 03/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit

class Day1View: BaseView, BaseViewInteractionDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var leftContainer: UIView!
    @IBOutlet private weak var leftInner: UIView!
    @IBOutlet private weak var leftBullet: UIView!
    @IBOutlet private weak var rightContainer: UIView!
    @IBOutlet private weak var rightInner: UIView!
    @IBOutlet private weak var rightBullet: UIView!
    
    // MARK: - Properties
    
    override var interactionMessage: String? {
        "Use tap and swipes to interact."
    }
    
    override var viewId: Int { 0 }
    
    private var black: UIColor!
    private var isAnimating: Bool = false
    private var isWhite: Bool = false
    private var isOppened: Bool = false
    
    // MARK: - Life cicle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.black = self.leftContainer.backgroundColor
        self.setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.setUpViews()
    }
    
    // MARK: - Aux functions
    
    private func setUpViews() {
        [leftInner, leftBullet, rightInner, rightBullet].forEach { view in
            if let v = view {
                DispatchQueue.main.async {
                    v.layer.cornerRadius = v.frame.height * 0.5
                    v.clipsToBounds = true
                }
            }
        }
    }
    
    // MARK: - BaseViewInteractionDelegate functions
    
    func didTap() {
        if !self.isAnimating {
            let color = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut, animations: {
                self.leftContainer.backgroundColor = self.isWhite ? self.black : .white
                self.leftInner.backgroundColor = self.isWhite ? self.black : .white
                self.leftBullet.backgroundColor = self.isWhite ? .white : self.black
                self.rightContainer.backgroundColor = !self.isWhite ? self.black : .white
                self.rightInner.backgroundColor = !self.isWhite ? self.black : .white
                self.rightBullet.backgroundColor = !self.isWhite ? .white : self.black
            })
            color.addCompletion { _ in
                self.isWhite = !self.isWhite
                self.isAnimating = false
            }
            self.isAnimating = true
            color.startAnimation()
        }
    }
    
    func didSwipeLeft() {
        if !self.isAnimating && self.isOppened {
            let open = UIViewPropertyAnimator(duration: 3, curve: .easeOut, animations: {
                self.leftContainer.frame.origin.x += self.view.frame.width
                self.leftInner.frame.origin.x += self.view.frame.width
                self.rightContainer.frame.origin.x -= self.view.frame.width
                self.rightInner.frame.origin.x -= self.view.frame.width
            })
            open.addCompletion { _ in
                self.isOppened = false
                self.isAnimating = false
            }
            self.isAnimating = true
            open.startAnimation()
        }
    }
    
    func didSwipeRight() {
        if !self.isAnimating && !self.isOppened {
            let open = UIViewPropertyAnimator(duration: 3, curve: .easeIn, animations: {
                self.leftContainer.frame.origin.x -= self.view.frame.width
                self.leftInner.frame.origin.x -= self.view.frame.width
                self.rightContainer.frame.origin.x += self.view.frame.width
                self.rightInner.frame.origin.x += self.view.frame.width
            })
            open.addCompletion { _ in
                self.isOppened = true
                self.isAnimating = false
            }
            self.isAnimating = true
            open.startAnimation()
        }
    }
    
    func didSwipeUp() {
        
    }
    
    func didSwipeDown() {
        
    }

}

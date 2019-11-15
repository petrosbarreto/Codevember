//
//  Day9View.swift
//  codevember
//
//  Created by Renan Germano on 13/11/19.
//  Copyright © 2019 Renan Germano. All rights reserved.
//

import UIKit
import SpriteKit

class Day9View: BaseView {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var skView: SKView!
    
    // MARK: - Properties
    
    override var activateGestures: Bool { false }
    
    override var viewId: Int { 8 }
    
    private var gameScene: GameScene!
    
    private var retry: Bool = false
    
    // MARK: - Life cicle functions

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.gameScene = GameScene(size: self.view.frame.size)
        gameScene.backgroundColor = self.view.backgroundColor ?? .clear
        gameScene.didFinishGameAction = self.didFinishGame
        self.skView.presentScene(gameScene, transition: .init())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showSelectDurationAlert()
    }
    
    // MARK: - Aux functions
    
    private func showSelectDurationAlert() {
        let alert = UIAlertController(title: "Duration", message: "Select the game duration", preferredStyle: .actionSheet)
        func set(_ value: Int) {
            alert.dismiss(animated: true, completion: {
                if self.retry {
                    self.gameScene.tryAgain(columns: value)
                    self.retry = false
                } else {
                    self.gameScene.setUpProperties(columns: value)
                    self.gameScene.createGame()
                }
            })
        }
        alert.addAction(UIAlertAction(title: "Fast", style: .default, handler: { _ in
            set(7)
        }))
        alert.addAction(UIAlertAction(title: "Medium", style: .default, handler: { _ in
            set(10)
        }))
        alert.addAction(UIAlertAction(title: "Long", style: .default, handler: { _ in
            set(15)
        }))
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    private func didFinishGame(total: Int, hitted: Int) {
        let alert = UIAlertController(title: "Game over", message: "You hitted \(hitted) balls of \(total)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play again", style: .default, handler: { _ in
            self.retry = true
            self.showSelectDurationAlert()}))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: {
                self.navigationController?.popViewController(animated: true)
            })
        }))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }


}

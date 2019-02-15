//
//  GameViewController.swift
//  2048
//
//  Created by Main on 2017/11/29.
//  Copyright © 2017年 Main. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private var skView: SKView!
    private var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView = SKView(frame: self.view.frame)
        scene = GameScene(size: skView.frame.size)
        scene.scaleMode = .aspectFit
        view.addSubview(skView)
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        var swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)
        
        scene.board.printBoard()
    }
    
    @objc func swipe(_ sender: UISwipeGestureRecognizer){
        scene.swipe(sender.direction)
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

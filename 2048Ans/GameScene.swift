//
//  GameScene.swift
//  2048
//
//  Created by Main on 2017/11/29.
//  Copyright © 2017年 Main. All rights reserved.
//

import SpriteKit
import GameplayKit

extension Int{
    var cf: CGFloat{return CGFloat(self)}
}

class GameScene: SKScene {
    var board: Board!
    ///　スワイプした時に１ます移動するのにかかる時間
    var swipeDuration: TimeInterval = 0.05
    private var isAnimation: Bool = false
    private var piaceLayer: SKNode!
    private var piaceSize: CGSize!
    private var backPiaceLayer: SKNode!
    
    override func didMove(to view: SKView) {
        let size = min(self.size.width, self.size.height) / CGFloat(Board.size)
        let piaceSize = CGSize(width: size, height: size)
        board = Board(piaceSize: piaceSize)
        self.piaceSize = piaceSize
        piaceLayer = SKNode()
        board.piaces.forEach{
            $0.forEach{
                piaceLayer.addChild($0.sprite)
            }
        }
        
        backPiaceLayer = SKNode()
        let texture = SKTexture(imageNamed: "frame.png")
        for y in 0..<Board.size{
            for x in 0..<Board.size{
                let node = SKSpriteNode(texture: texture, color: .clear, size: piaceSize)
                node.anchorPoint = CGPoint(x: 0 , y: 0)
                node.position = CGPoint(x: CGFloat(x) * piaceSize.width, y: CGFloat(y) * piaceSize.height)
                backPiaceLayer.addChild(node)
            }
        }
        
        self.addChild(backPiaceLayer)
        self.addChild(piaceLayer)
        
        
        let c = center(size: CGSize(width: piaceSize.width * CGFloat(Board.size), height: piaceSize.height * CGFloat(Board.size)))
        piaceLayer.position = CGPoint(x: c.minX, y: c.minY)
        backPiaceLayer.position = CGPoint(x: c.minX, y: c.minY)
    }
    
    func center(size: CGSize)-> CGRect{
        let width = self.size.width / 2
        let height = self.size.height / 2
        let sWidth = size.width / 2
        let sHeight = size.height / 2
        return CGRect(x: width - sWidth, y: height - sHeight, width: size.width, height: size.height)
    }
    
    func swipe(_ direction: UISwipeGestureRecognizerDirection){
        if isAnimation{
            return
        }
        board.swipe(direction, animation: self.animation)
    }
    
    private func animation(_ completion: @escaping () -> ()){
        isAnimation = true
        let piaces = board.piaces
        var max: Double = 0
        for y in 0..<Board.size{
            for x in 0..<Board.size{
                let piace = piaces[y][x]
                let moveTo = CGPoint(x: CGFloat(x) * piaceSize.width, y: CGFloat(y) * piaceSize.height)
                let dx = x - Int(piace.point.x)
                let dy = y - Int(piace.point.y)
                let d = sqrt(Double(dx * dx + dy * dy))
                if max < d{
                    max = d
                }
                let action = SKAction.move(to: moveTo, duration: swipeDuration * d)
                piace.sprite.run(action, completion: {
                    piace.point = CGPoint(x: x, y: y)
                })
            }
        }
        
        let node = SKNode()
        self.addChild(node)
        node.run(SKAction.wait(forDuration: max * swipeDuration), completion: {
            self.isAnimation = false
            completion()
            node.removeFromParent()
        })
        
    }
}


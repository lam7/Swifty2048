//
//  Piace.swift
//  2048
//
//  Created by Main on 2017/12/04.
//  Copyright © 2017年 Main. All rights reserved.
//

import Foundation
import SpriteKit
import ChameleonFramework

///ラベル付きSKSpriteNode
class SKSpriteNodeWithLabel: SKSpriteNode{
    private(set) var labelNode: SKLabelNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp(){
        labelNode = SKLabelNode()
        labelNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        self.addChild(labelNode)
    }
}

class Piace{
    ///SpriteKitで使うノード
    private(set) var sprite: SKSpriteNodeWithLabel
    ///現在の自身の数字
    private(set) var num: Int
    
    var point: CGPoint
    
    static let colors: [UIColor] = [.clear, .flatWhite, .flatWhiteDark, .flatPowderBlue, .flatPowderBlueDark, .flatBlue, .flatBlueDark, .flatGray, .flatGrayDark, .flatNavyBlue, .flatNavyBlueDark, .flatBlack]
    
    init(point: CGPoint, size: CGSize){
        //num = 0で壁
        num = 0
        
        // spriteを初期化
        // 色は好きに決める
        // サイズは引数
        sprite = SKSpriteNodeWithLabel(texture: nil, color: Piace.colors[0], size: size)
        
        // sprite.positionをpoint * sizeに変更
        sprite.position = CGPoint(x: point.x * size.width, y: point.y * size.height)
        
        sprite.anchorPoint = CGPoint(x: 0, y: 0)
        // pointは引数で初期化
        self.point = point
    }
    
    
    
    
    /// 自身の数字を新しい数字に更新
    /// ラベルのテキストを自身の数字に更新
    func set(num: Int){
        self.num = num
        sprite.labelNode.text = num.description
        var color: UIColor
        if num == 0{
         color = Piace.colors[0]
        }else{
         color = Piace.colors[Int(log2(Double(num)))]
        }
        sprite.color = color
        
    }
    
    /// ピースを初期化
    func initPiace(){
        set(num: 0)
        sprite.labelNode.text = ""
    }
    
    /// 2つのピース(引数と自身)を結合させる
    /// setNumを呼び出し数字を更新させる
    /// 引数の方のpiaceのinitPiaceを呼び出して初期化させる
    func connect(_ piace: Piace){
        set(num: self.num + piace.num)
        piace.initPiace()
    }
}

//
//  Board.swift
//  2048
//
//  Created by Main on 2017/12/04.
//  Copyright © 2017年 Main. All rights reserved.
//

import Foundation
import SpriteKit


extension Int{
    var random: Int{
        return Int(arc4random_uniform(UInt32(self)))
    }
}
class Board{
    ///盤面サイズ size*sizeの盤面を作る
    static let size = 4
    
    ///盤面のピース
    private(set) var piaces: [[Piace]] = []
    
    private var piaceSize: CGSize
    
    init(piaceSize: CGSize){
        // piacesを初期化する
        // piacesにsize*sizeのPiace配列を入れる
        // frameはx: piaceSize.width * x, y: piaceSize * y, width: piaceSize.width, height: piaceSize.height
        for y in 0..<Board.size{
            var raw: [Piace] = []
            for x in 0..<Board.size{
                raw.append(Piace(point: CGPoint(x: x, y: y), size: piaceSize))
            }
            piaces.append(raw)
        }
        
        //自身のpiaceSizeを引数で初期化
        self.piaceSize = piaceSize
        
        for _ in 0..<2{
            let point = randomPiacePoint()!
            piaces[point.y][point.x].set(num: 2)
        }
        
    }
    
    private func randomPiacePoint()-> (x: Int, y: Int)?{
        var points: [(x: Int, y: Int)] = []
        for y in 0..<piaces.count{
            for x in 0..<piaces[y].count{
                if piaces[y][x].num == 0{
                    points.append((x: x, y: y))
                }
            }
        }
        if points.isEmpty{
            return nil
        }
        let rand = Int(arc4random_uniform(UInt32(points.count)))
        return points[rand]
    }
    
    /// スワイプした時の処理
    /// 新たな場所に2を追加
    func swipe(_ direction: UISwipeGestureRecognizerDirection, animation: ((_ completion: @escaping () -> ()) -> ())){
        var share: Swipe
        
        switch direction {
        case .left:
            share = SwipeLeft()
        case .right:
            share = SwipeRight()
        case .up:
            share = SwipeUp()
        case .down:
            share = SwipeDown()
        default:
            fatalError()
        }
        
        //スワイプ不可能なら終了
        if !share.swipe(&piaces){
            print("false")
            self.printBoard()
            return
        }
        print("true")
        
        animation{
            guard let point = self.randomPiacePoint() else{
                print("finish")
                return
            }
            if arc4random_uniform(10) == 0{
                self.piaces[point.y][point.x].set(num: 4)
            }else{
                self.piaces[point.y][point.x].set(num: 2)
            }
            
            self.printBoard()
        }
    }
    
    
    func printBoard(){
        print("<-----------------------")
        for line in piaces.reversed(){
            var text = ""
            for piace in line{
                text += piace.num.description
                text += " "
            }
            print(text)
        }
        print("----------------------->")
        print()
        print()
    }
    
    static func printBoard(piaces: [[Piace]]){
        print("<-----------------------")
        for line in piaces.reversed(){
            var text = ""
            for piace in line{
                text += piace.num.description
                text += " "
            }
            print(text)
        }
        print("----------------------->")
        print()
        print()
    }
    
    
}

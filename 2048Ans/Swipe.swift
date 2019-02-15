//
//  Swipe.swift
//  2048Ans
//
//  Created by Main on 2017/12/08.
//  Copyright © 2017年 Main. All rights reserved.
//

import Foundation
import SpriteKit

class Swipe{
    /// 詰める、結合する、詰める
    ///
    /// - Parameter piaces: ピース
    /// - Returns:  スワイプ可能ならtrueを返す
    func swipe(_ piaces: inout [[Piace]])-> Bool{
        Board.printBoard(piaces: piaces)
        let copy = piaces
        fill(&piaces)
        connect(&piaces)
        fill(&piaces)
        Board.printBoard(piaces: piaces)
        return !isEqual(copy, piaces)
    }
    
    fileprivate func isEqual(_ lhs: [[Piace]], _ rhs: [[Piace]])-> Bool{
        for y in 0..<Board.size{
            for x in 0..<Board.size{
                if lhs[y][x].num != rhs[y][x].num{
                    return false
                }
            }
        }
        return true
    }
    
    fileprivate func connect(_ piaces: inout [[Piace]]){}
    
    fileprivate func fill(_ piaces: inout [[Piace]]){}
}

class SwipeLeft: Swipe{
    /// 0でないピースを左側に詰めていく
    /// piacesを一列ずつ見ていく
    /// ゼロでないピースを配列に取っていき、その後ゼロのピースを配列に取る
    /// そして出来た配列をresultに入れていく
    /// 出来たresultをpiacesに代入する
    override fileprivate func fill(_ piaces: inout [[Piace]]){
        var result: [[Piace]] = []
        for line in piaces{
            let noZero: [Piace] = line.filter({ $0.num != 0 })
            let zero: [Piace] = line.filter({ $0.num == 0})
            let connect = noZero + zero
            result.append(connect)
        }
        piaces = result
    }
    
    /// 左から順に見て同じ数字が隣り合っているなら結合させる
    override fileprivate func connect(_ piaces: inout [[Piace]]) {
        for line in piaces{
            for i in 0..<line.count - 1{
                if line[i].num == 0{
                    continue
                }
                if line[i].num == line[i+1].num{
                    line[i].connect(line[i+1])
                }
            }
        }
    }
}

class SwipeRight: Swipe{    
    /// 0でないピースを左側に詰めていく
    /// piacesを一列ずつ見ていく
    /// ゼロでないピースを配列に取っていき、その後ゼロのピースを配列に取る
    /// そして出来た配列をresultに入れていく
    /// 出来たresultをpiacesに代入する
    override fileprivate func fill(_ piaces: inout [[Piace]]){
        var result: [[Piace]] = []
        for line in piaces{
            let noZero: [Piace] = line.filter({ $0.num != 0 })
            let zero: [Piace] = line.filter({ $0.num == 0})
            let connect = zero + noZero
            result.append(connect)
        }
        piaces = result
    }
    
    /// 左から順に見て同じ数字が隣り合っているなら結合させる
    override fileprivate func connect(_ piaces: inout [[Piace]]) {
        for line in piaces{
            for i in (1..<line.count).reversed(){
                if line[i].num == 0{
                    continue
                }
                if line[i].num == line[i-1].num{
                    line[i].connect(line[i-1])
                }
            }
        }
    }
}


class SwipeUp: Swipe{
   
    /// 0でないピースを左側に詰めていく
    /// piacesを一列ずつ見ていく
    /// ゼロでないピースを配列に取っていき、その後ゼロのピースを配列に取る
    /// そして出来た配列をresultに入れていく
    /// 出来たresultをpiacesに代入する
    override fileprivate func fill(_ piaces: inout [[Piace]]){
        var result: [[Piace]] = []
        rotate(&piaces)
        for line in piaces{
            let noZero: [Piace] = line.filter({ $0.num != 0 })
            let zero: [Piace] = line.filter({ $0.num == 0})
            let connect = zero + noZero
            result.append(connect)
        }
        rotate(&result)
        piaces = result
    }
    
    /// 左から順に見て同じ数字が隣り合っているなら結合させる
    override fileprivate func connect(_ piaces: inout [[Piace]]) {
        rotate(&piaces)
        for line in piaces{
            for i in (1..<line.count).reversed(){
                if line[i].num == 0{
                    continue
                }
                if line[i].num == line[i-1].num{
                    line[i].connect(line[i-1])
                }
            }
        }
        rotate(&piaces)
    }
    
    // 0 1 2    0 3 6
    // 3 4 5 -> 1 4 7
    // 6 7 8    2 5 8
    private func rotate(_ piaces: inout [[Piace]]){
        var rotate: [[Piace]] = []
        
        for x in 0..<Board.size{
            var line: [Piace] = []
            for y in 0..<Board.size{
                line.append(piaces[y][x])
            }
            rotate.append(line)
        }
        piaces = rotate
    }

}


class SwipeDown: Swipe{
    override fileprivate func fill(_ piaces: inout [[Piace]]){
        var result: [[Piace]] = []
        rotate(&piaces)
        for line in piaces{
            let noZero: [Piace] = line.filter({ $0.num != 0 })
            let zero: [Piace] = line.filter({ $0.num == 0})
            let connect = noZero + zero
            result.append(connect)
        }
        rotate(&result)
        piaces = result
    }
    
    /// 左から順に見て同じ数字が隣り合っているなら結合させる
    override fileprivate func connect(_ piaces: inout [[Piace]]) {
        rotate(&piaces)
        for line in piaces{
            for i in 0..<line.count - 1{
                if line[i].num == 0{
                    continue
                }
                if line[i].num == line[i+1].num{
                    line[i].connect(line[i+1])
                }
            }
        }
        rotate(&piaces)
    }
    
    // 0 1 2    0 3 6
    // 3 4 5 -> 1 4 7
    // 6 7 8    2 5 8
    private func rotate(_ piaces: inout [[Piace]]){
        var rotate: [[Piace]] = []
        
        for x in 0..<Board.size{
            var line: [Piace] = []
            for y in 0..<Board.size{
                line.append(piaces[y][x])
            }
            rotate.append(line)
        }
        piaces = rotate
    }
}



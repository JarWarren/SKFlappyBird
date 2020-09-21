//
//  Bird.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/21/20.
//

import SpriteKit

class Bird: SKSpriteNode {

    private var maximumVelocity: CGFloat = 18
    private var upwardMomentum: CGFloat = 0
    var isAlive = true
    
    func setUp() {
        
    }
    
    func flap() {
        guard isAlive else { return }
        upwardMomentum = maximumVelocity
    }
    
    func update() {
        if upwardMomentum > -maximumVelocity {
            upwardMomentum -= 1
        }
        if position.y >= -380 {
            position.y += upwardMomentum
        }
    }
}

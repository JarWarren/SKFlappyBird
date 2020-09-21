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
    
    func setUp() {
        
    }
    
    func flap() {
        upwardMomentum = maximumVelocity
    }
    
    func die() {
        
    }
    
    func update() {
        if upwardMomentum > -maximumVelocity {
            upwardMomentum -= 1
        }
        position.y += upwardMomentum
    }
}

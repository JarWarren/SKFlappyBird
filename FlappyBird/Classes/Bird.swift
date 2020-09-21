//
//  Bird.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/21/20.
//

import SpriteKit

class Bird: SKSpriteNode {

    private var maximumUpwardVelocity: CGFloat = 18
    private var upwardVelocity: CGFloat = 0
    private var maximumAngularVelocity: CGFloat = 1
    private var angularVelocity: CGFloat = 0
    private var textures = [SKTexture]()
    var isAlive = true
    
    func setUp() {
        guard let color = ["red", "yellow", "blue"].randomElement() else { return }
        textures = [SKTexture(imageNamed: color + "bird-upflap"),
                    SKTexture(imageNamed: color + "bird-midflap"),
                    SKTexture(imageNamed: color + "bird-downflap")]
        texture = textures[1]
    }
    
    func flap() {
        guard isAlive else { return }
        removeAllActions()
        upwardVelocity = maximumUpwardVelocity
        zRotation = 0.7
        run(.repeat(.animate(with: textures, timePerFrame: 0.06), count: 2)) {
            self.texture = self.textures[1]
            self.run(.rotate(toAngle: -1.57, duration: 0.36))
        }
    }
    
    func update() {
        if upwardVelocity > -maximumUpwardVelocity * 2 {
            upwardVelocity -= 1
        }
        
        if position.y >= -350 {
            position.y += upwardVelocity
        }
    }
}

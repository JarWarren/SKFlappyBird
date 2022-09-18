//
//  Bird.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/21/20.
//

import SpriteKit

class Bird: SKSpriteNode {

    private var flapSound: SKAction { .playSoundFileNamed(Constants.sounds.flap, waitForCompletion: false) }
    private var deathSound: SKAction { .playSoundFileNamed(Constants.sounds.death, waitForCompletion: false) }
    private var maximumUpwardVelocity: CGFloat = 18
    private var upwardVelocity: CGFloat = 0
    private var maximumAngularVelocity: CGFloat = 1
    private var angularVelocity: CGFloat = 0
    private var textures = [SKTexture]()
    private var isAlive = true
    private var state: GameState = .ready
    
    func flap() {
        guard isAlive, position.y < Constants.gameplay.birdUpperLimit else { return }
        removeAllActions()
        upwardVelocity = maximumUpwardVelocity
        zRotation = 0.7
        run(flapSound)
        run(.repeat(.animate(with: textures, timePerFrame: 0.06), count: 2)) {
            self.fall()
        }
    }
    
    func fly() {
        position.y = 0
        zRotation = 0
        run(.repeatForever(.animate(with: textures, timePerFrame: 0.1)))
    }
    
    func fall() {
        texture = self.textures[1]
        run(.rotate(toAngle: -1.57, duration: 0.36))
    }
}

extension Bird: GameObject {
    func setUp() {
        guard let color = ["red", "yellow", "blue"].randomElement() else { return }
        textures = [SKTexture(imageNamed: color + "bird-upflap"),
                    SKTexture(imageNamed: color + "bird-midflap"),
                    SKTexture(imageNamed: color + "bird-downflap")]
		textures.forEach { $0.filteringMode = .nearest }
        texture = textures[1]
        fly()
    }

    func update() {
        if upwardVelocity > -maximumUpwardVelocity * 2 {
            upwardVelocity -= 1
        }
        
        if position.y >= -350 && state != .ready {
            position.y += upwardVelocity
        }
    }
    
    func changeState(to state: GameState) {
        self.state = state
        removeAllActions()
        switch state {
        case .ready:
            isAlive = true
            fly()
        case .playing:
            flap()
        case .gameOver:
            isAlive = false
            fall()
            if position.y >= 300 {
                run(deathSound)
            }
        }
    }
}

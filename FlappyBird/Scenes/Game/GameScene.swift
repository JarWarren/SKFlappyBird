//
//  GameScene.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/20/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private lazy var background: Background = childNode(withName: "Background") as! Background
    private lazy var ground: Ground = childNode(withName: "Ground") as! Ground
    private lazy var bird: Bird = childNode(withName: "Bird") as! Bird
    private lazy var pipes: [Pipe] = [childNode(withName: "Pipe0") as! Pipe,
                                      childNode(withName: "Pipe1") as! Pipe,
                                      childNode(withName: "Pipe2") as! Pipe]
    
    var score = 0
    
    override func didMove(to view: SKView) {
        background.setUp()
        pipes.forEach { $0.setUp(delegate: self) }
        ground.setUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        physicsWorld.contactDelegate = self
        bird.flap()
    }
    
    override func update(_ currentTime: TimeInterval) {
        pipes.forEach { $0.update() }
        ground.update()
        bird.update()
    }
}

extension GameScene: PipeDelegate {
    func pipeDidPassCenterScreen() {
        score += 1
        print(score)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        ground.shouldUpdate = false
        pipes.forEach { $0.shouldUpdate = false }
        bird.isAlive = false
    }
}

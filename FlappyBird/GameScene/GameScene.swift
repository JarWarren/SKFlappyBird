//
//  GameScene.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/20/20.
//

import SpriteKit
import GameplayKit

enum GameState {
    case ready
    case playing
    case gameOver
}

protocol GameObject: AnyObject {
    func changeState(to state: GameState)
    func setUp()
    func update()
}

class GameScene: SKScene {
    
    private var onCooldown = false
    private var collisionSound: SKAction { .playSoundFileNamed(Constants.sounds.collision, waitForCompletion: false) }
    private var scoreSound: SKAction { .playSoundFileNamed(Constants.sounds.score, waitForCompletion: false) }
    private var swooshSound: SKAction { .playSoundFileNamed(Constants.sounds.swoosh, waitForCompletion: false) }
    private lazy var background = childNode(withName: "Background") as! Background
    private lazy var readyMessage = childNode(withName: "Message") as! SKSpriteNode
    private lazy var gameOverMessage = childNode(withName: "GameOver") as! SKSpriteNode
    private lazy var ground = gameObject(name: "Ground")
    private lazy var bird = gameObject(name: "Bird") as! Bird
    private lazy var score = gameObject(name: "Score")
    private lazy var pipes = [gameObject(name: "Pipe0") as! Pipe,
                              gameObject(name: "Pipe1") as! Pipe,
                              gameObject(name: "Pipe2") as! Pipe]
    
    private var gameState: GameState = .ready {
        didSet {
            switch gameState {
            case .ready:
                readyGame()
            case .playing:
                playGame()
            case .gameOver:
                endGame()
            }
            updateGameObjectStates()
        }
    }
    
    override func didMove(to view: SKView) {
        readyGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !onCooldown else { return }
        switch gameState {
        case .ready:
            gameState = .playing
        case .playing:
            physicsWorld.contactDelegate = self
            bird.flap()
        case .gameOver:
            gameState = .ready
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        pipes.forEach { $0.update() }
        ground.update()
        bird.update()
    }
    
    private func readyGame() {
        run(swooshSound)
        readyMessage.isHidden = false
        gameOverMessage.isHidden = true
        background.setUp()
        pipes.forEach { $0.setUp(); $0.delegate = self }
        ground.setUp()
        bird.setUp()
        score.setUp()
    }
    
    private func playGame() {
        readyMessage.isHidden = true
        gameOverMessage.isHidden = true
    }
    
    private func endGame() {
        run(swooshSound)
        readyMessage.isHidden = true
        gameOverMessage.isHidden = false
    }
    
    private func updateGameObjectStates() {
        ground.changeState(to: gameState)
        pipes.forEach { $0.changeState(to: gameState) }
        bird.changeState(to: gameState)
        score.changeState(to: gameState)
    }
}

extension GameScene: PipeDelegate {
    func pipeDidScore() {
        score.update()
        run(scoreSound)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard gameState != .gameOver else { return }
        self.gameState = .gameOver
        run(collisionSound)
        onCooldown = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
            self.onCooldown = false
        }
    }
}

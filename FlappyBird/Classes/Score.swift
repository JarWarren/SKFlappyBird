//
//  Score.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/21/20.
//

import SpriteKit

class Score: SKNode {
    
    private var score = 0
    private lazy var firstDigit = childNode(withName: "FirstDigit") as? SKSpriteNode
    private lazy var secondDigit = childNode(withName: "SecondDigit") as? SKSpriteNode
    private let textures = [SKTexture(imageNamed: "0"),
                            SKTexture(imageNamed: "1"),
                            SKTexture(imageNamed: "2"),
                            SKTexture(imageNamed: "3"),
                            SKTexture(imageNamed: "4"),
                            SKTexture(imageNamed: "5"),
                            SKTexture(imageNamed: "6"),
                            SKTexture(imageNamed: "7"),
                            SKTexture(imageNamed: "8"),
                            SKTexture(imageNamed: "9")]
}

extension Score: GameObject {
    func setUp() {
        isHidden = true
        firstDigit?.position.x = 0
        secondDigit?.isHidden = true
		textures.forEach { $0.filteringMode = .nearest }
    }
    
    func update() {
        score += 1
        if score > 9 {
            secondDigit?.isHidden = false
            firstDigit?.position.x = -34
            firstDigit?.texture = textures[score / 10]
            secondDigit?.texture = textures[score % 10]
        } else {
            firstDigit?.texture = textures[score]
        }
        
    }
    
    func changeState(to state: GameState) {
        isHidden = state == .ready
        if state == .ready {
            score = -1
            firstDigit?.position.x = 0
            update()
        }
    }
}

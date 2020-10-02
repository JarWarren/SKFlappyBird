//
//  Pipe.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/20/20.
//

import SpriteKit

protocol PipeDelegate: AnyObject {
    func pipeDidScore()
}

class Pipe: SKNode {
    private var hasScored = false
    private var shouldUpdate = false
    weak var delegate: PipeDelegate?
    
    private func reset() {
        if position.x < Constants.gameplay.pipeLimitRight {
            position.x += 1080
        }
        position.y = CGFloat.random(in: Constants.gameplay.pipeSafeRange)
        hasScored = false
    }
}

extension Pipe: GameObject {
    func setUp() {
        reset()
    }

    func update() {
        guard shouldUpdate else { return }
        position.x -= Constants.gameplay.gameSpeed
        
        if !hasScored && position.x <= Constants.gameplay.birdPosition {
            hasScored = true
            delegate?.pipeDidScore()
        }
        
        if position.x <= Constants.gameplay.pipeLimitLeft {
            reset()
        }
    }
    
    func changeState(to state: GameState) {
        if state == .playing {
            reset()
            shouldUpdate = true
        } else {
            shouldUpdate = false
        }
    }
}

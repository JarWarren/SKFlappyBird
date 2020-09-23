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
    private var shouldUpdate = true
    weak var delegate: PipeDelegate?
    
    private func reset() {
        position.x += 1080
        position.y = CGFloat.random(in: -80...240)
        hasScored = false
    }
}

extension Pipe: GameObject {
    func setUp() {
        reset()
    }

    func update() {
        guard shouldUpdate else { return }
        position.x -= Constants.gameSpeed
        
        if !hasScored && position.x <= -160 {
            hasScored = true
            delegate?.pipeDidScore()
        }
        
        if position.x <= -640 {
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

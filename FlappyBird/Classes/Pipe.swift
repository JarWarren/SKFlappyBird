//
//  Pipe.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/20/20.
//

import SpriteKit

protocol PipeDelegate: AnyObject {
    func pipeDidPassCenterScreen()
}

class Pipe: SKNode {
    
    private weak var delegate: PipeDelegate?
    private var hasPassedCenter = false
    var shouldUpdate = true
    
    func setUp(delegate: PipeDelegate) {
        self.delegate = delegate
        reset()
    }

    func update() {
        guard shouldUpdate else { return }
        position.x -= 3
        
        if !hasPassedCenter && position.x <= 0 {
            hasPassedCenter = true
            delegate?.pipeDidPassCenterScreen()
        }
        
        if position.x <= -640 {
            reset()
        }
    }
    
    private func reset() {
        position.x += 1080
        position.y = CGFloat.random(in: -80...240)
        hasPassedCenter = false
    }
}

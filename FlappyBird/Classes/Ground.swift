//
//  Ground.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/21/20.
//

import SpriteKit

class Ground: SKNode {

    private var segments = [SKSpriteNode]()
    private var leadSegment = 0
    var shouldUpdate = true
    
    func setUp() {
        segments = [childNode(withName: "Segment0") as! SKSpriteNode,
                    childNode(withName: "Segment1") as! SKSpriteNode,
                    childNode(withName: "Segment2") as! SKSpriteNode]
    }
    
    func update() {
        guard shouldUpdate else { return }
        segments.forEach { $0.position.x -= 3 }
        if segments[leadSegment].position.x <= -820 {
            segments[leadSegment].position.x += segments[leadSegment].size.width * 3
            updateLeadSegment()
        }
    }
    
    private func updateLeadSegment() {
        leadSegment += 1
        if leadSegment > 2 {
            leadSegment = 0
        }
    }
    
}

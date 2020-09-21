//
//  Background.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/21/20.
//

import SpriteKit

class Background: SKSpriteNode {
    
    func setUp() {
        var textureName = "background-"
        textureName += Bool.random() ? "day" : "night"
        self.texture = SKTexture(imageNamed: textureName)
    }
}

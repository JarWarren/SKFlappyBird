//
//  SKScene+Extension.swift
//  FlappyBird
//
//  Created by Jared Warren on 9/22/20.
//

import SpriteKit

extension SKScene {
    func gameObject(name: String) -> GameObject {
        return childNode(withName: name) as! GameObject
    }
}

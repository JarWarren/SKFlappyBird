//
//  Constants.swift
//  FlappyBird
//
//  Created by Jared Warren on 10/2/20.
//

import CoreGraphics

enum Constants {
    
    static let sounds = SoundConstants()
    static let gameplay = GameplayConstants()
        
}

struct SoundConstants {
    let collision = "hit.wav"
    let death = "die.wav"
    let flap = "wing.wav"
    let score = "point.wav"
    let swoosh = "swoosh.wav"
}

struct GameplayConstants {
    let birdPosition: CGFloat = -160
    let birdUpperLimit: CGFloat = 600
    let gameSpeed: CGFloat = 4
    let pipeLimitLeft: CGFloat = -640
    let pipeLimitRight: CGFloat = 2000
    let pipeSafeRange: ClosedRange<CGFloat> = -80...240
}

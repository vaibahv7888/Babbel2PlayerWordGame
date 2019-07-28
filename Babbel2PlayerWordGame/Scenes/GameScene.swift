//
//  GameScene.swift
//  Babbel2PlayerWordGame
//
//  Created by Vaibhav Bangde on 7/27/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    lazy var buzzerButtonOne : GameButton = {
        let button = GameButton(imageName: "BuzzerRed", titleLabel: "Buzzer 1", buttonAction: {
            print("buzzerButtonTwo clicked")
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
    lazy var buzzerButtonTwo : GameButton = {
        let button = GameButton(imageName: "BuzzerRed", titleLabel: "Buzzer 2", buttonAction: {
            print("buzzerButtonTwo clicked")
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
    override func didMove(to view: SKView) {
        print("In GameScene didMove")
        layoutScene()
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addBuzzerButtons()
    }
    
    func addBuzzerButtons () {
        buzzerButtonOne.position = CGPoint(x: frame.minX + buzzerButtonOne.button.size.width*0.75, y: frame.minY + buzzerButtonOne.button.size.height*0.65)
        addChild(buzzerButtonOne)
        buzzerButtonTwo.position = CGPoint(x: frame.maxX - buzzerButtonTwo.button.size.width*0.75, y: frame.minY + buzzerButtonTwo.button.size.height*0.65)
        addChild(buzzerButtonTwo)
    }
}

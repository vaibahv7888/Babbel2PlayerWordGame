//
//  GameScene.swift
//  Babbel2PlayerWordGame
//
//  Created by Vaibhav Bangde on 7/27/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private var mainWordLbl : SKLabelNode!
    private var translatedWordLbl : SKLabelNode!
    private var scorePlayerOneLbl : SKLabelNode!
    private var scorePlayerTwoLbl : SKLabelNode!
    private var rightAnswerLbl : SKLabelNode!
    private var wrongAnswerLbl : SKLabelNode!

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
        addLables()
        addBuzzerButtons()
    }
    
    func addBuzzerButtons () {
        buzzerButtonOne.position = CGPoint(x: frame.minX + buzzerButtonOne.button.size.width*0.75, y: frame.minY + buzzerButtonOne.button.size.height*0.65)
        addChild(buzzerButtonOne)
        buzzerButtonTwo.position = CGPoint(x: frame.maxX - buzzerButtonTwo.button.size.width*0.75, y: frame.minY + buzzerButtonTwo.button.size.height*0.65)
        addChild(buzzerButtonTwo)
    }
    
    func addLables() {
        self.mainWordLbl = SKLabelNode(text: "")
        self.mainWordLbl.position = CGPoint(x: frame.midX, y: frame.maxY*0.75)
        self.mainWordLbl.fontColor = SKColor.white
        self.mainWordLbl.fontName = "BubbleGum"
        addChild(self.mainWordLbl)
        
        self.translatedWordLbl = SKLabelNode(text: "")
        translatedWordLbl.position = CGPoint(x: frame.minX, y: frame.maxY)
        translatedWordLbl.fontColor = SKColor.white
        translatedWordLbl.fontName = "BubbleGum"
        addChild(translatedWordLbl)
        
        self.scorePlayerOneLbl = SKLabelNode(text: "0")
        self.scorePlayerOneLbl.position = CGPoint(x: frame.maxX*0.10, y: frame.maxY*0.85)
        self.scorePlayerOneLbl.fontColor = SKColor.white
        self.scorePlayerOneLbl.fontName = "BubbleGum"
        addChild(self.scorePlayerOneLbl)
        
        self.scorePlayerTwoLbl = SKLabelNode(text: "0")
        self.scorePlayerTwoLbl.position = CGPoint(x: frame.maxX*0.90, y: frame.maxY*0.85)
        self.scorePlayerTwoLbl.fontColor = SKColor.white
        self.scorePlayerTwoLbl.fontName = "BubbleGum"
        addChild(self.scorePlayerTwoLbl)
        
        self.rightAnswerLbl = SKLabelNode(text: "Right Answer")
        self.rightAnswerLbl.fontName = "BubbleGum"
        self.rightAnswerLbl.fontSize = labelFontTo(screenWithPercentage: 0.10)
        self.rightAnswerLbl.fontColor = SKColor.green
        self.rightAnswerLbl.zPosition = 1
        self.rightAnswerLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        self.rightAnswerLbl.alpha = 0
        addChild(self.rightAnswerLbl)
        
        self.wrongAnswerLbl = SKLabelNode(text: "Wrong Answer")
        self.wrongAnswerLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        self.wrongAnswerLbl.fontColor = SKColor.red
        self.wrongAnswerLbl.fontName = "BubbleGum"
        self.wrongAnswerLbl.zPosition = 1
        self.wrongAnswerLbl.fontSize = labelFontTo(screenWithPercentage: 0.10)
        self.wrongAnswerLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        self.wrongAnswerLbl.alpha = 0
        addChild(self.wrongAnswerLbl)
    }

    func labelFontTo(screenWithPercentage: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * screenWithPercentage
    }

}

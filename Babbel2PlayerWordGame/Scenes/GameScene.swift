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
    private var goodGoingLbl : SKLabelNode!
    private var scores : Score!
    private var isAnswerInProcess = false
    private var mainWord : Words!
    private var translatedWord : Words!

    let fetchWordsData : FetchWordsDataProtocol!
    
    lazy var buzzerButtonOne : GameButton = {
        let button = GameButton(imageName: "BuzzerRed", titleLabel: "Buzzer 1", buttonAction: {
            if !self.isAnswerInProcess {
                self.isAnswerInProcess = true
                self.processAnswer(for: .one)
            }
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
    lazy var buzzerButtonTwo : GameButton = {
        let button = GameButton(imageName: "BuzzerRed", titleLabel: "Buzzer 2", buttonAction: {
            if !self.isAnswerInProcess {
                self.isAnswerInProcess = true
                self.processAnswer(for: .two)
            }
        })
        button.zPosition = 1
        button.scaleTo(screenWithPercentage: 0.15)
        return button
    }()
    
    override init(size: CGSize) {
        fetchWordsData = FetchWordsData(fileName: "words")
        scores = Score(playerOneScore: 0, playerTwoScore: 0)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        print("In GameScene didMove")
        layoutScene()
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLables()
        addBuzzerButtons()
        displayScore()
        startNewMainWord()
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
        
        self.goodGoingLbl = SKLabelNode(text: "Good Going")
        self.goodGoingLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        self.goodGoingLbl.fontColor = SKColor.green
        self.goodGoingLbl.fontName = "BubbleGum"
        self.goodGoingLbl.zPosition = 1
        self.goodGoingLbl.fontSize = labelFontTo(screenWithPercentage: 0.05)
        self.goodGoingLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        self.goodGoingLbl.alpha = 0
        addChild(self.goodGoingLbl)
    }

    func startNewMainWord() {
        removeTransition()
        getWords()
        getNextTranslatedWord()
        startWord()
    }
    
    func removeTransition() {
        translatedWordLbl.removeAllActions()
        translatedWordLbl.position = CGPoint(x: frame.minX-200, y: frame.midY)
    }
    
    func getWords() {
        guard let mainWord = self.fetchWordsData.getMainWord() else { return }
        self.mainWord = mainWord
        self.mainWordLbl.text = mainWord.text_eng
    }
    
    func getNextTranslatedWord() {
        guard let translatedWord = self.fetchWordsData.getRandomWord(except: mainWord) else { return }
        self.translatedWord = translatedWord
        self.translatedWordLbl.text = translatedWord.text_spa
    }
    
    func startWord() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: frame.minX, y: frame.midY))
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.midY))
        let followLine = SKAction.follow(path, asOffset: false, orientToPath: false, duration: 3)
        translatedWordLbl.run(followLine) {
            self.getNextTranslatedWord()
            self.startWord()
        }
    }
    
    func checkAnswer() -> Bool {
        return self.mainWord == self.translatedWord
    }
    
    func addScore(for player:Player) {
        switch player {
        case .one:
            self.scores.playerOneScore += 1
            break
        case .two:
            self.scores.playerTwoScore += 1
            break
        }
        displayScore()
    }
    
    func displayScore() {
        self.scorePlayerOneLbl.text = "\(self.scores.playerOneScore)"
        self.scorePlayerTwoLbl.text = "\(self.scores.playerTwoScore)"
    }
    
    func animateAnswerLabel(label:SKLabelNode) {
        let scaleUp = SKAction.scale(by: 1.05, duration: 0.2)
        let scaleDown = SKAction.scale(by: 0.95, duration: 0.2)
        label.alpha = 1.0
        label.run(SKAction.sequence([scaleUp, scaleDown, scaleUp, scaleDown, scaleUp, scaleDown, SKAction.run({
            label.alpha = 0
            self.isAnswerInProcess = false
            self.startNewMainWord()
        })]))
    }
    
    func processAnswer(for player: Player) {
        self.removeTransition()
        if self.checkAnswer() {
            self.addScore(for: player)
            switch player {
            case .one:
                if scores.playerOneScore % 5 == 0 {
                    appreciatePlayers(score: scores.playerOneScore)
                } else {
                    animateAnswerLabel(label: self.rightAnswerLbl)
                }
                break
            case .two:
                if scores.playerOneScore % 5 == 0 {
                    appreciatePlayers(score: scores.playerOneScore)
                } else {
                    animateAnswerLabel(label: self.rightAnswerLbl)
                }
                break
            }
        } else {
            animateAnswerLabel(label: self.wrongAnswerLbl)
        }
    }
    
    func appreciatePlayers(score: Int) {
        let scr = String(score)
        let text = "Good Going reached " + scr + " points"
        self.goodGoingLbl.text = text
        self.goodGoingLbl.alpha = 1
        self.goodGoingLbl.run(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.run({
            self.goodGoingLbl.alpha = 0
            self.animateAnswerLabel(label: self.rightAnswerLbl)
        })]))
    }
    
    func labelFontTo(screenWithPercentage: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * screenWithPercentage
    }

}

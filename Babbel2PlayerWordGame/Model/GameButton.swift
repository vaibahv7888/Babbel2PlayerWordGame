//
//  GameButton.swift
//  Babbel2PlayerWordGame
//
//  Created by Vaibhav Bangde on 7/27/19.
//  Copyright © 2019 Vaibhav Bangde. All rights reserved.
//

import SpriteKit

class GameButton : SKNode {
    var button : SKSpriteNode
    private var mask : SKSpriteNode
    private var cropNode : SKCropNode
    private var action : () -> Void
    private var isEnabled = true
    private var titleLabel : SKLabelNode?
    
    init(imageName: String, titleLabel: String? = "", buttonAction: @escaping()->Void) {
        button = SKSpriteNode(imageNamed: imageName)
        self.titleLabel = SKLabelNode(text: titleLabel)
        
        mask = SKSpriteNode(color: SKColor.black, size: button.size)
        mask.alpha = 0
        
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        
        action = buttonAction
        
        super.init()
        
        isUserInteractionEnabled = true
        
        setupNodes()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNodes() {
        button.zPosition = 0
        
        if let titleLabel = self.titleLabel {
            titleLabel.fontName = "BubbleGum"
            titleLabel.fontSize = titleFontTo(screenWithPercentage: 0.025)
            titleLabel.fontColor = SKColor.white
            titleLabel.zPosition = 1
            titleLabel.horizontalAlignmentMode = .center
            titleLabel.verticalAlignmentMode = .center
        }
    }
    
    func addNodes() {
        addChild(button)
        if let titleLbl = self.titleLabel {
            addChild(titleLbl)
        }
        addChild(cropNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            mask.alpha = 0.5
            run(SKAction.scale(by: 1.05, duration: 0.05))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location = touch.location(in: self)
                
                if button.contains(location) {
                    mask.alpha = 0.5
                } else {
                    mask.alpha = 0.0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location = touch.location(in: self)
                
                if button.contains(location) {
                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.scale(by: 0.95, duration: 0.05), SKAction.run({
                        self.enable()
                    })]))
                }
            }
        }
    }
    
    func disable() {
        isEnabled = false
        mask.alpha = 0.0
        button.alpha = 0.5
    }
    
    func enable() {
        isEnabled = true
        mask.alpha = 0.0
        button.alpha = 1.0
    }
    
    func scaleTo(screenWithPercentage: CGFloat) {
        let aspectRatio = button.size.height / button.size.width
        
        button.size.width = UIScreen.main.bounds.size.width * screenWithPercentage
        button.size.height = button.size.width * aspectRatio
    }
    
    func titleFontTo(screenWithPercentage: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * screenWithPercentage
    }
    
    func logAvailableFonts() {
        for family in UIFont.familyNames {
            print("\(family)")
            for fontName in UIFont.fontNames(forFamilyName: family) {
                print("== \(fontName)")
            }
        }
    }
}

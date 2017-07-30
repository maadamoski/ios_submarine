//
//  menuScene.swift
//  submarine
//
//  Created by PUCPR on 12/11/16.
//  Copyright © 2016 PUCPR. All rights reserved.
//

import SpriteKit


class MenuScene: SKScene {
    
    var playButton = SKSpriteNode()
    let playButtonTex = SKTexture(imageNamed: "play3.png")
    
    
    
    

    
  
    
    
    
    override func didMove(to view: SKView) {
        
        
        
        playButton = SKSpriteNode(texture: playButtonTex, size: self.size)
        playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        
        self.addChild(playButton)
        let backgroundMusic = SKAudioNode(fileNamed: "Menu1f.mp3")
        
        backgroundMusic.autoplayLooped = true
        
        addChild(backgroundMusic)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
                if view != nil {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = SubmarineScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            }
        }
    }
}

//
//  SettingsMenu.swift
//  Wall
//
//  Created by Shumeng Guo on 12/11/2017.
//  Copyright © 2017 ShowmiCreations. All rights reserved.
//

import SpriteKit

class SettingsMenu : SKScene {
    
    var soundTick = SKSpriteNode()
    var musicTick = SKSpriteNode()
    
    
    
    override func didMove(to view: SKView) {
        soundTick = self.childNode(withName: "soundTick") as! SKSpriteNode
        musicTick = self.childNode(withName: "musicTick") as! SKSpriteNode

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "quitBtn" {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    
                    //set the scene to fit the window
                    scene.scaleMode = .aspectFit
                    
                    //present the scene
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.1))
                }
            }
            else if atPoint(location).name == "soundTick" {
                if soundTick.texture == SKTexture(imageNamed: "blueBoxTick") {
                    soundTick.texture = SKTexture(imageNamed:"greyCircle")
                    print("yes")
                }
                else if soundTick.texture == SKTexture(imageNamed: "greyCircle") {
                    soundTick.texture = SKTexture(imageNamed: "blueBoxTick")
                    print("no")
                }
                
            }
            else if atPoint(location).name == "musicTick" {
                if musicTick.texture == SKTexture(imageNamed: "blueBoxTick") {
                    musicTick.texture = SKTexture(imageNamed:"greyCircle")
                    print("yes")
                }
                else if musicTick.texture == SKTexture(imageNamed:"grey_circle"){
                    musicTick.texture = SKTexture(imageNamed: "blueBoxTick")
                    print("no")
                }
            }
        }
    }
                
    override func update(_ currentTime: TimeInterval) {
        
    }
}

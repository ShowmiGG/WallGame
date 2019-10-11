//
//  MainMenu.swift
//  Wall
//
//  Created by Shumeng Guo on 11/11/2017.
//  Copyright © 2017 ShowmiCreations. All rights reserved.
//

import Foundation
import SpriteKit


class MainMenu : SKScene {
    
    var topWall = SKSpriteNode()
    var botWall = SKSpriteNode()
    var color = 0
    var currentColor = 0
    var randomColor : UIColor = green
    
    override func didMove(to view: SKView) {
        topWall = self.childNode(withName: "topWall") as! SKSpriteNode
        botWall = self.childNode(withName: "botWall") as! SKSpriteNode
        
        topWall.color = red
        botWall.color = red
        
        changeColor(object: topWall)
        changeColor(object: botWall)
        
    }
    
    func changeColor(object: SKSpriteNode) {
        object.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run {
                    object.run(SKAction.colorize(with: self.getRandomColor(), colorBlendFactor: 1, duration: 1))
                },
                SKAction.wait(forDuration: 1)])
        ))
    }
    func getRandomColor() -> UIColor {
        while currentColor == color {
            color = Int(arc4random_uniform(3))
        }
        currentColor = color
            
        if color == 0 {
            randomColor = red
        }
        else if color == 1{
            randomColor = green
        }
        else if color == 2{
            randomColor = blue
        }
        return randomColor
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if atPoint(location).name == "playBtn" {
                if let scene = GamePlay(fileNamed: "GamePlay") {
                    
                    //set the scene to fit the window
                    scene.scaleMode = .aspectFit
                    
                    //present the scene
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.1))
                }
            }
            else if atPoint(location).name == "highscoreBtn" {
                if let scene = HighscoreMenu(fileNamed: "HighscoreMenu") {
                    
                    //set the scene to fit the window
                    scene.scaleMode = .aspectFit
                    
                    //present the scene
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.1))
                }
            }
            else if atPoint(location).name == "settingsBtn" {
                if let scene = SettingsMenu(fileNamed: "SettingsMenu") {
                    
                    //set the scene to fit the window
                    scene.scaleMode = .aspectFit
                    
                    //present the scene
                    view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.1))
                }
            }
            else if atPoint(location).name == "quitBtn" {
                
            }
            else {
                
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func update(_ currentTime: TimeInterval) {
        
    }
}

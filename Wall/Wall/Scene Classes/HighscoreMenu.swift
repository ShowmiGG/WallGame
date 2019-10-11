//
//  HighscoreMenu.swift
//  Wall
//
//  Created by Shumeng Guo on 12/11/2017.
//  Copyright © 2017 ShowmiCreations. All rights reserved.
//

import SpriteKit

class HighscoreMenu : SKScene {
    override func didMove(to view: SKView) {
        
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
        }
    }
    override func update(_ currentTime: TimeInterval) {
        
    }
}

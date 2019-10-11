//
//  GamePlay.swift
//  Wall
//
//  Created by Shumeng Guo on 11/11/2017.
//  Copyright © 2017 ShowmiCreations. All rights reserved.
//

import Foundation
import SpriteKit

var red = UIColor(red: 244.0/255, green: 130.0/255, blue: 42.0/255, alpha: 1.0)
var green = UIColor(red: 126.0/255, green: 211.0/255, blue: 85.0/255, alpha: 1.0)
var blue = UIColor(red: 34.0/255, green: 176.0/255, blue: 229.0/255, alpha: 1.0)

class GamePlay : SKScene, SKPhysicsContactDelegate {
    
    var ball = SKShapeNode(circleOfRadius: 20)
    var topWall = SKSpriteNode()
    var botWall = SKSpriteNode()
    var scoreLbl = SKLabelNode()
    
    var againMenu = SKSpriteNode()
    var againLbl = SKLabelNode()
    var againBtn = SKSpriteNode()
    var quitBtn = SKSpriteNode()
    
    
    var color = 0
    var currentColor = 0
    var score = 0
    var initialDX = CGFloat()
    var initialDY = CGFloat()
    var gameEnd = false
    
    
    func startGame() {
        gameEnd = false
        createBall()
        createEdge()
        topWall.color = green
        botWall.color = green
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        againMenu.position = CGPoint(x: -400, y: 0)
        againLbl.position = CGPoint(x: -400, y: 10)
        againBtn.position = CGPoint(x: -480, y: -50)
        quitBtn.position = CGPoint(x: -320, y: -50)
        score = 0
        scoreLbl.text = "\(score)"
    }
    
    func createBall() {
        ball.position = CGPoint(x: 0, y: 0)
        ball.strokeColor = green
        ball.fillColor = green
        ball.zPosition = 1
        ball.glowWidth = 0.0
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.contactTestBitMask = 5
    }
    
    func createEdge() {
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        topWall = self.childNode(withName: "topWall") as! SKSpriteNode
        botWall = self.childNode(withName: "botWall") as! SKSpriteNode
        scoreLbl = self.childNode(withName: "scoreLbl") as! SKLabelNode
        
        againMenu = self.childNode(withName: "againMenu") as! SKSpriteNode
        againLbl = self.childNode(withName: "againLbl") as! SKLabelNode
        againBtn = self.childNode(withName: "againBtn") as! SKSpriteNode
        quitBtn = self.childNode(withName: "quitBtn") as! SKSpriteNode
        
        
        createBall()
        self.addChild(ball)
        
        createEdge()
        
        startGame()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        while currentColor == color {
            color = Int(arc4random_uniform(3))
        }
        currentColor = color
        if color == 0 {
            topWall.color = red
            botWall.color = red
        }
        else if color == 1 {
            topWall.color = green
            botWall.color = green
        }
        else if color == 2 {
            topWall.color = blue
            botWall.color = blue
        }
        
        if againMenu.position.x == 0{
            for touch in touches {
                let location = touch.location(in: self)
                if atPoint(location).name == "againBtn" {
                    startGame()
                }
                else if atPoint(location).name == "quitBtn"{
                    if let scene = HighscoreMenu(fileNamed: "MainMenu") {
                        
                        //set the scene to fit the window
                        scene.scaleMode = .aspectFit
                        
                        //present the scene
                        view!.presentScene(scene, transition: SKTransition.crossFade(withDuration: 0.1))
                        
                    }
                    
                }
            }
        }
    }
    
    
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        if gameEnd == false {
            if contact.bodyA.contactTestBitMask == contact.bodyB.contactTestBitMask {
                if ball.fillColor == botWall.color {
                    addScore()
                }
                else if  ball.fillColor == topWall.color {
                    addScore()
                }
                else {
                    gameEnd = true
                    let action = SKAction.moveTo(x: 0, duration: 2)
                    ball.speed = 0
                    ball.physicsBody?.isDynamic = true
                    ball.physicsBody?.allowsRotation = true
                    ball.physicsBody?.affectedByGravity = true
                    ball.physicsBody?.friction = 0
                    ball.physicsBody?.restitution = 0.5
                    ball.physicsBody?.angularDamping = 0.1
                    ball.physicsBody?.linearDamping = 0.1
                    botWall.physicsBody?.restitution = 0.5
                    botWall.physicsBody?.restitution = 0.5
                    againMenu.run(action)
                    againLbl.run(action)
                    againBtn.run(SKAction.moveTo(x: -80, duration: 2))
                    quitBtn.run(SKAction.moveTo(x: 80, duration: 2))
                }
                
                
                while currentColor == color {
                    color = Int(arc4random_uniform(3))
                }
                currentColor = color
                if color == 0 {
                    ball.fillColor = red
                    ball.strokeColor = red
                }
                else if color == 1 {
                    ball.fillColor = green
                    ball.strokeColor = green
                }
                else if color == 2 {
                    ball.fillColor = blue
                    ball.strokeColor = blue
                }
                
                addSpeed()
            }
        }
        
    }
    
    func addSpeed() {
        // decrease this to adjust the amount of speed gained each frame :)
        let amount = CGFloat(50)
        // When bouncing off a wall, speed decreases... this corrects that to _increase speed_ off bounces.
        if (ball.physicsBody?.velocity.dx)! < initialDX {
            if Int((ball.physicsBody?.velocity.dy)!) < 0 {
                ball.physicsBody?.velocity.dx = -initialDX - amount
            }
            else if Int((ball.physicsBody?.velocity.dx)!) > 0 {
                ball.physicsBody?.velocity.dx =  initialDX + amount
            }
        }
        if (ball.physicsBody?.velocity.dy)! < initialDY {
            if Int((ball.physicsBody?.velocity.dy)!) < 0 {
                ball.physicsBody?.velocity.dy = -initialDY - amount
            }
            else if Int((ball.physicsBody?.velocity.dy)!) > 0 {
                ball.physicsBody?.velocity.dy =  initialDY + amount
            }
        }
    }
    
    func addScore() {
        score += 1
        scoreLbl.text = "\(score)"
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        initialDX = ball.physicsBody!.velocity.dx
        initialDY = ball.physicsBody!.velocity.dy
    }
}

































//
//  GameScene.swift
//  TankTV
//
//  Created by trainermac on 4/7/16.
//  Copyright (c) 2016 eldervaz. All rights reserved.
//


import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var bg : SKSpriteNode!
    var helicopter :SKSpriteNode = SKSpriteNode(imageNamed: "0")
    
    var base : SKSpriteNode!
    
    var touchPositionX: CGFloat = 0.0
    var touchPositionY: CGFloat = 0.0
    
    let BaseCategory:UInt32     = 1<<0
    let PlayerCategory:UInt32   = 1<<1
    let PeopleCategory:UInt32   = 1<<2
    let BlockCategory:UInt32   = 1<<3
    
    let scoreLabel = SKLabelNode(fontNamed: "Snake Jacket")
    var score:Int = 0
    
    var lastUpdateTime:NSTimeInterval? = 0.0
    var stopMove:Bool! = false
    
    
    override func didMoveToView(view: SKView) {
        
        initBG()
        initPlayer()
        initBase()
        
        //
        //initPeople()
        initPhysics()
        initFont()
        
        //repeatActionForever
        runAction(SKAction.repeatAction(
            SKAction.sequence([
                    SKAction.runBlock(initPeople),
                    SKAction.waitForDuration(0.50)
                ]), count: 10
            )
        )
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        for touch in touches{
            
            touchPositionX = touch.locationInNode(self).x
            touchPositionY = touch.locationInNode(self).y
            
        }
        
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        
        
        for touch in touches{
            
            let location = touch.locationInNode(self)
            
            if touchPositionX != 0.0 && touchPositionY != 0.0 {
                
                
                let deltaX = touchPositionX - location.x
                let deltaY = touchPositionY - location.y
                
                var x = helicopter.position.x - deltaX
                var y = helicopter.position.y - deltaY
                
                if x < 0 {
                    x = 0
                }else if x > self.frame.width{
                    x = self.frame.width
                }
                
                if y < 0{
                    y = 0
                }else if y > self.frame.height{
                    y = self.frame.height
                }
                
                
                helicopter.position =  CGPoint(x: x, y: y)
                
                
            }
            
            
            if stopMove == false {
            
                touchPositionX = location.x
                touchPositionY = location.y
            
            }
            
            
            
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        scoreLabel.text = "SCORE: \(score)"
        
        //_  = currentTime - lastUpdateTime!
        self.lastUpdateTime = currentTime;
        
        if ( stopMove == true ){
            stopMove = false
        }
    }
    
    func initFont(){
        
        
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.fontSize = 50
        scoreLabel.zPosition = 100
        
        scoreLabel.text = "SCORE: \(score)"
        addChild(scoreLabel)
        
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        scoreLabel.position = CGPoint(x: 100, y: size.height - 300)
        
        
    }
    
    func initPhysics(){
        
        physicsWorld.contactDelegate = self
        
        helicopter.physicsBody = SKPhysicsBody(rectangleOfSize: helicopter.size)
        helicopter.physicsBody?.allowsRotation = false
        helicopter.physicsBody?.affectedByGravity = false
        
        helicopter.physicsBody?.categoryBitMask = PlayerCategory
        helicopter.physicsBody?.contactTestBitMask = PeopleCategory | BaseCategory | BlockCategory
        
        
        base.physicsBody = SKPhysicsBody(rectangleOfSize: base.size)
        base.physicsBody?.allowsRotation = false
        base.physicsBody?.affectedByGravity = false
        
        base.physicsBody?.categoryBitMask = BaseCategory
        base.physicsBody?.contactTestBitMask = PlayerCategory
        base.physicsBody?.collisionBitMask = 0
        
        
        initBlocks()
        
    }
    
    func initBlocks(){
        
        let contorno = SKSpriteNode()
        addChild(contorno)
        
        
        let block1 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.frame.size.width, height: 2000) )
        block1.position = CGPoint(x: size.width/2, y:  size.height + 700)
        contorno.addChild(block1)
        
        let block2 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.frame.size.width, height: 2000) )
        block2.position = CGPoint(x: size.width/2, y:  -750)
        contorno.addChild(block2)
        
        let block3 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 2000, height: self.frame.size.height) )
        block3.position = CGPoint(x: -950, y: size.height/2 - 100 )
        contorno.addChild(block3)
        
        let block4 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 2000, height: self.frame.size.height) )
        block4.position = CGPoint(x: size.width + 950, y: size.height/2 - 100 )
        contorno.addChild(block4)
        //
        block1.name = "block"
        block2.name = "block"
        block3.name = "block"
        block4.name = "block"
        
        //
        block1.physicsBody = SKPhysicsBody(rectangleOfSize: block1.size)
        block1.physicsBody?.allowsRotation = false
        block1.physicsBody?.affectedByGravity = false
        
        block1.physicsBody?.categoryBitMask = BlockCategory
        block1.physicsBody?.contactTestBitMask = PlayerCategory
        block1.physicsBody?.collisionBitMask = 0
        //
        block2.physicsBody = SKPhysicsBody(rectangleOfSize: block2.size)
        block2.physicsBody?.allowsRotation = false
        block2.physicsBody?.affectedByGravity = false
        
        block2.physicsBody?.categoryBitMask = BlockCategory
        block2.physicsBody?.contactTestBitMask = PlayerCategory
        block2.physicsBody?.collisionBitMask = 0
        //
        block3.physicsBody = SKPhysicsBody(rectangleOfSize: block3.size)
        block3.physicsBody?.allowsRotation = false
        block3.physicsBody?.affectedByGravity = false
        
        block3.physicsBody?.categoryBitMask = BlockCategory
        block3.physicsBody?.contactTestBitMask = PlayerCategory
        block3.physicsBody?.collisionBitMask = 0
        //
        block4.physicsBody = SKPhysicsBody(rectangleOfSize: block4.size)
        block4.physicsBody?.allowsRotation = false
        block4.physicsBody?.affectedByGravity = false
        
        block4.physicsBody?.categoryBitMask = BlockCategory
        block4.physicsBody?.contactTestBitMask = PlayerCategory
        block4.physicsBody?.collisionBitMask = 0
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        
        if firstBody.categoryBitMask == PlayerCategory &&  secondBody.categoryBitMask == PeopleCategory{
            secondBody.node?.removeFromParent()
            
            score += 1
            
            if score >= 10 {
                let gameWin = SceneWin(size: size)
                gameWin.scaleMode = scaleMode
                let showScene = SKTransition.doorsOpenHorizontalWithDuration(1.5)
                view?.presentScene(gameWin, transition: showScene)
            }
        }
    
        
        if firstBody.categoryBitMask == PlayerCategory &&  secondBody.categoryBitMask == BlockCategory{
            print("colllision")
            stopMove = true
            
        }
        
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    
    func initPeople(){
        
        
        let person = SKSpriteNode(imageNamed: "people")
        person.name = "person"
        
        let actualY = random(min: person.size.height * 5, max: size.height - person.size.height * 6)
        let actualX = random(min: person.size.width * 5, max: size.width - person.size.width * 6)
        
        person.position = CGPoint(x:  actualX, y: actualY)
        person.zPosition = 2
        addChild( person )
        
        
        person.physicsBody = SKPhysicsBody(rectangleOfSize: person.size)
        person.physicsBody?.allowsRotation = false
        person.physicsBody?.affectedByGravity = false
        
        person.physicsBody?.categoryBitMask = PeopleCategory
        person.physicsBody?.contactTestBitMask = PlayerCategory
        person.physicsBody?.collisionBitMask = 0
        
        
    }
    
    func initBG() {
        bg = SKSpriteNode(imageNamed: "bg")
        bg.position = CGPoint(x: size.width/2, y: size.height/2)
        bg.zPosition = -1
        bg.lightingBitMask = 1
        bg.name = "bg"
        addChild(bg)
        
        
    }
    
    func initPlayer(){
        
        var textures:[SKTexture] = []
        for i in 0...11 {
            textures.append( SKTexture(imageNamed: "\(i)") )
        }
        let anima = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        helicopter.runAction(
            SKAction.group([
                SKAction.repeatActionForever(anima),
                SKAction.speedTo(2.5, duration: 0)
            ]), withKey:"animation"
        )
        
        
        //helicopter = SKSpriteNode(imageNamed: "helicopterTOP")
        helicopter.position = CGPoint(x: size.width/2, y: size.height/2 )
        helicopter.zPosition = 0
        helicopter.name = "player"
        addChild(helicopter)
        
        let light = SKLightNode()
        light.position = CGPoint(x: 50.0, y: 0)
        light.categoryBitMask = 1
        light.falloff = 2
        light.ambientColor = UIColor.blackColor()
        light.lightColor = UIColor.whiteColor()
        light.xScale = 20
        light.name = "light"
        helicopter.addChild(light)
        
    }
    
    func initBase(){
        base = SKSpriteNode(imageNamed: "buildings")
        base.position = CGPoint(x: size.width - base.frame.size.width, y: base.frame.size.height * 1.5)
        base.zPosition = 1
        base.size = CGSize(width: base.size.width/2, height: base.size.height/2)
        base.name = "base"
        addChild(base)
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}


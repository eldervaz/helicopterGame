//
//  SceneWin.swift
//  TankTV
//
//  Created by trainermac on 4/7/16.
//  Copyright © 2016 eldervaz. All rights reserved.
//

import Foundation
import SpriteKit


class SceneWin: SKScene {
    
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error al implementar el init")
    }
    
    override func didMove(to view: SKView) {
        
        let bg:SKSpriteNode = SKSpriteNode(imageNamed: "win")
        bg.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild( bg )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let gameScene = GameScene(size: size)
        gameScene.scaleMode = scaleMode
        
        let showGame = SKTransition.doorsOpenVertical(withDuration: 1)
        
        view?.presentScene(gameScene, transition:  showGame)
        
        
    }
    
    
    
    
}

//
//  GameViewController.swift
//  TankTV
//
//  Created by trainermac on 4/7/16.
//  Copyright (c) 2016 eldervaz. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
        let scene = GameScene(size: CGSize(width: 2048, height: 1536) )
        
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
        //skView.showsPhysics = true
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .aspectFill
            skView.presentScene(scene)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

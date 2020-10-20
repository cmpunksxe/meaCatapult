//
//  GameViewController.swift
//  meaCatapult
//
//  Created by Nik on 09.07.2020.
//  Copyright © 2020 meaCom. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
      

      // Detect the screensize
      let sizeRect = UIScreen.main.applicationFrame
      let width = sizeRect.size.width * UIScreen.main.scale
      let height = sizeRect.size.height * UIScreen.main.scale

      // Scene should be shown in fullscreen mode
      let scene = GameScene(size: CGSize(width: width, height: height))
      scene.backgroundColor = .white

      // Configure the view.
      let skView = self.view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true

      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true

      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .aspectFill

      skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

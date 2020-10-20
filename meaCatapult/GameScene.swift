//
//  GameScene.swift
//  meaCatapult
//
//  Created by Nik on 09.07.2020.
//  Copyright © 2020 meaCom. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var winner : SKLabelNode?
    private var onePointLabel : SKLabelNode?
    private var twoPointLabel : SKLabelNode?
    private var scoreLabel : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var ball: SKSpriteNode!
  
    var bottomFirstBasket: SKSpriteNode!
    var bottomSecondBasket: SKSpriteNode!
    var bottomThirdBasket: SKSpriteNode!
    var bottomFourthBasket: SKSpriteNode!
    var slideLine: SKSpriteNode!
  
    var topFirstBasket: SKSpriteNode!
    var topSecondBasket: SKSpriteNode!
    var topThirdBasket: SKSpriteNode!
    var slideLineTop: SKSpriteNode!
  
    let backView = UIImageView()
    var congratsView = UIImageView()

    var player: AVAudioPlayer?
    var background: SKSpriteNode!
    var backgroundImageNames = ["marcel-schreiber-hav_Fg0OSMc-unsplash","jean-philippe-delberghe-jQ2FtAnmmfc-unsplash","edgar-chaparro-_T-D4Bb-H88-unsplash"]
    var selectedBackgroundIndex = 0
    var score = 0
    var winScore = 25

    override func didMove(to view: SKView) {
     
      //add splash image
      addSplashImage()
      
      physicsWorld.gravity = CGVector(dx: 0, dy: 0)
      physicsWorld.contactDelegate = self
      background = SKSpriteNode(imageNamed: backgroundImageNames[selectedBackgroundIndex])
      background.zPosition = 0
      background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
      addChild(background)

      setupScoreLabel()
      setupBall()
      setupBottomLineBaskets()
      setupTopLineBaskets()
    
//      scoreLabel!.text = ""
//      scoreLabel!.fontSize = 70
//      scoreLabel!.fontColor = SKColor.green
//      scoreLabel!.position = CGPoint(x: 100, y: 100)
//      addChild(scoreLabel!)
    }
  
  func setupScoreLabel() {
    
          winner = SKLabelNode()
          winner!.text = "\(score)/\(winScore)"
          winner!.fontName = "SanFranciscoDisplay-Bold"
          winner!.fontSize = 70
          winner!.fontColor = SKColor.white
          winner!.position = CGPoint(x: frame.size.width - 100, y: frame.size.height - 100)
          winner!.zPosition = 5
          addChild(winner!)
          
          onePointLabel = SKLabelNode()
          onePointLabel!.fontName = "SanFranciscoDisplay-Bold"
          onePointLabel!.text = "+1"
          onePointLabel!.fontSize = 70
          onePointLabel!.fontColor = UIColor(red: 0.87, green: 0.04, blue: 0.11, alpha: 1.00)
          onePointLabel!.position = CGPoint(x: frame.size.width - 70, y: frame.size.height - 470)
          onePointLabel!.zPosition = 5
          addChild(onePointLabel!)
    
          twoPointLabel = SKLabelNode()
          twoPointLabel!.fontName = "SanFranciscoDisplay-Bold"
          twoPointLabel!.text = "+2"
          twoPointLabel!.fontSize = 70
    twoPointLabel!.fontColor = SKColor.green
          twoPointLabel!.position = CGPoint(x: frame.size.width - 70, y: frame.size.height - 245)
          twoPointLabel!.zPosition = 5
          addChild(twoPointLabel!)
  }
  
  //add splash image
  func addSplashImage(){
      
      let splashImage = UIImage(named: "splash.png")
      let splashImageView = UIImageView(image: splashImage)
      splashImageView.contentMode = .scaleAspectFill
      splashImageView.frame = self.view!.frame
      self.view!.addSubview(splashImageView)
      self.view!.bringSubviewToFront(splashImageView)
        UIView.animate(withDuration: 0.3, delay: 2.0, options: .transitionFlipFromLeft, animations: {() -> Void in
            let y: CGFloat = 0.0
          splashImageView.frame = CGRect(x: -(self.view!.frame.size.width), y: y, width: (self.view!.frame.size.width), height: (self.view!
                .frame.size.height))
        }, completion: {(_ finished: Bool) -> Void in
            if finished {
                splashImageView.removeFromSuperview()
            }
        })
  }
  
    func setupBall() {
      ball = SKSpriteNode(imageNamed: "ball")
      ball.size = CGSize(width: 100, height: 100)
      ball.position = CGPoint(x: self.frame.size.width / 2, y: ball.size.height / 2 + 20)
      ball.zPosition = 1
      ball.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
      ball.physicsBody?.isDynamic = false
      ball.physicsBody?.categoryBitMask = 1
      ball.physicsBody?.contactTestBitMask = 1
      self.addChild(ball)
  }
  
  func setupBottomLineBaskets() {
    
    let distanceBeetweenBaskets: Double = Double((self.frame.size.width)/4) + 30
    slideLine = SKSpriteNode()
    slideLine.size = CGSize(width: self.frame.size.width - 200, height: 225)
    slideLine.position = CGPoint(x: Double(self.frame.size.width / 2), y: Double(self.frame.size.height - 450))
    slideLine.color = .clear
    slideLine.zPosition = 2
    slideLine.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
    slideLine.physicsBody?.isDynamic = false
    slideLine.physicsBody?.categoryBitMask = 1
    slideLine.physicsBody?.contactTestBitMask = 1
    
   let basketSize = CGSize(width: 300, height: 225)
   bottomFirstBasket = SKSpriteNode(imageNamed: "cup1")
   bottomFirstBasket.size = basketSize
   bottomFirstBasket.position = CGPoint(x: Double((-slideLine.frame.size.width/2) + 50), y: 10)
   bottomFirstBasket.zPosition = 2
   bottomFirstBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
   bottomFirstBasket.physicsBody?.isDynamic = false
   bottomFirstBasket.physicsBody?.categoryBitMask = 1
   bottomFirstBasket.physicsBody?.contactTestBitMask = 1

  bottomSecondBasket = SKSpriteNode(imageNamed: "cup1")
  bottomSecondBasket.size = basketSize
  bottomSecondBasket.position = CGPoint(x: Double(-slideLine.frame.size.width/2) + distanceBeetweenBaskets, y: 10)
  bottomSecondBasket.zPosition = 2
  bottomSecondBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
  bottomSecondBasket.physicsBody?.isDynamic = false
  bottomSecondBasket.physicsBody?.categoryBitMask = 1
  bottomSecondBasket.physicsBody?.contactTestBitMask = 1

  bottomThirdBasket = SKSpriteNode(imageNamed: "cup1")
  bottomThirdBasket.size = basketSize
  bottomThirdBasket.position = CGPoint(x: Double(-slideLine.frame.size.width/2) + distanceBeetweenBaskets*2, y: 10)
  bottomThirdBasket.zPosition = 2
  bottomThirdBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
  bottomThirdBasket.physicsBody?.isDynamic = false
  bottomThirdBasket.physicsBody?.categoryBitMask = 1
  bottomThirdBasket.physicsBody?.contactTestBitMask = 1

  bottomFourthBasket = SKSpriteNode(imageNamed: "cup1")
  bottomFourthBasket.size = basketSize
  bottomFourthBasket.position = CGPoint(x: Double(-slideLine.frame.size.width/2) + distanceBeetweenBaskets*3, y: 10)
  bottomFourthBasket.zPosition = 2
  bottomFourthBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
  bottomFourthBasket.physicsBody?.isDynamic = false
  bottomFourthBasket.physicsBody?.categoryBitMask = 1
  bottomFourthBasket.physicsBody?.contactTestBitMask = 1
    
  slideLine.addChild(bottomFirstBasket)
  slideLine.addChild(bottomSecondBasket)
  slideLine.addChild(bottomThirdBasket)
  slideLine.addChild(bottomFourthBasket)
    
  self.addChild(slideLine)

    // Prepare base actions
    let moveLeftAction4 = SKAction.move(to: CGPoint(x: self.frame.size.width/2 - 50, y: self.frame.size.height - 450), duration: 2.0)
    let moveRightAction4 = SKAction.move(to: CGPoint(x: (self.frame.size.width)/2 + 130, y: self.frame.size.height - 450), duration: 2.0)

    // Prepare sequencing
    let loopCount = 1000
    let leftRightAction4 = SKAction.sequence([moveLeftAction4, moveRightAction4])

    let pingPongAction = SKAction.repeat(leftRightAction4, count: loopCount)

    // Run final action
    slideLine.run(pingPongAction)
   }
  
  func setupTopLineBaskets() {
    
    let distanceBeetweenBaskets: Double = Double((self.frame.size.width)/3) + 30
      slideLineTop = SKSpriteNode()
      slideLineTop.size = CGSize(width: self.frame.size.width - 200, height: 225)
      slideLineTop.position = CGPoint(x: Double(self.frame.size.width / 2), y: Double(self.frame.size.height - 225))
      slideLineTop.color = .clear
      slideLineTop.zPosition = 2
      slideLineTop.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
      slideLineTop.physicsBody?.isDynamic = false
      slideLineTop.physicsBody?.categoryBitMask = 1
      slideLineTop.physicsBody?.contactTestBitMask = 1
    
     let basketSize = CGSize(width: 300  , height: 225)

     topFirstBasket = SKSpriteNode(imageNamed: "cup2")
     topFirstBasket.size = basketSize
     topFirstBasket.position = CGPoint(x: Double((-slideLine.frame.size.width/2) + 50), y: 10)
     topFirstBasket.zPosition = 2
     topFirstBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
     topFirstBasket.physicsBody?.isDynamic = false
     topFirstBasket.physicsBody?.categoryBitMask = 1
     topFirstBasket.physicsBody?.contactTestBitMask = 1
    
    topSecondBasket = SKSpriteNode(imageNamed: "cup2")
    topSecondBasket.size = basketSize
    topSecondBasket.position = CGPoint(x: Double(-slideLine.frame.size.width/2) + distanceBeetweenBaskets, y: 10)
    topSecondBasket.zPosition = 2
    topSecondBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
    topSecondBasket.physicsBody?.isDynamic = false
    topSecondBasket.physicsBody?.categoryBitMask = 1
    topSecondBasket.physicsBody?.contactTestBitMask = 1
    
    topThirdBasket = SKSpriteNode(imageNamed: "cup2")
    topThirdBasket.size = basketSize
    topThirdBasket.position = CGPoint(x: Double(-slideLine.frame.size.width/2) + distanceBeetweenBaskets*2, y: 10)
    topThirdBasket.zPosition = 2
    topThirdBasket.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
    topThirdBasket.physicsBody?.isDynamic = false
    topThirdBasket.physicsBody?.categoryBitMask = 1
    topThirdBasket.physicsBody?.contactTestBitMask = 1

    slideLineTop.addChild(topFirstBasket)
    slideLineTop.addChild(topSecondBasket)
    slideLineTop.addChild(topThirdBasket)

    self.addChild(slideLineTop)


    // Prepare base actions
    let moveLeftAction = SKAction.move(to: CGPoint(x: self.frame.size.width/2 - 50, y: self.frame.size.height - 225), duration: 1.5)
    let moveRightAction = SKAction.move(to: CGPoint(x: self.frame.size.width/2 + CGFloat(distanceBeetweenBaskets/2), y: self.frame.size.height - 225), duration: 1.5)

    // Prepare sequencing
    let loopCount = 1000
    let leftRightAction = SKAction.sequence([moveLeftAction, moveRightAction])

    let pingPongAction = SKAction.repeat(leftRightAction, count: loopCount)

    // Run final action
    slideLineTop.run(pingPongAction)

   }
  
  func showScore(value: Int) {
    self.scoreLabel!.text = "+\(value)"
    self.scoreLabel!.alpha = 1
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.scoreLabel!.alpha = 0
    }
  }
  
  func checWinTheGame() -> Bool{
    if score >= winScore {
      playSound(Resource:"complete", Extension:"wav")
      animateImage()
      score = 0
      winner!.text = "\(score)/\(winScore)"
      return true
    }
    return false
  }
  
  //add a congratulation image when player score 25 points
  func animateImage(){
            
      let congratsImageArray = ["congrats1.png","congrats2.png","congrats3.png","congrats4.png","congrats5.png"]
      let imageIndex = Int(arc4random() % UInt32(congratsImageArray.count))
      
      //create a backview with alpha 0.7
      backView.frame = self.view!.frame
      backView.backgroundColor = UIColor.black
      backView.alpha = 0.7
      
      //create a imageview
      let congratsImage = UIImage(named: congratsImageArray[imageIndex])
      congratsView = UIImageView(image: congratsImage)
      congratsView.contentMode = .scaleAspectFit
      congratsView.frame = CGRect(x: backView.frame.size.width/4, y: backView.frame.size.height/4, width: backView.frame.size.width/2, height: backView.frame.size.height/2)
      congratsView.alpha = 1.0
     
      //add the views to parent view
      self.view!.addSubview(backView)
      self.view!.addSubview(congratsView)
      
      //smaller the views
      backView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
      congratsView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
      
      //animate the view
      UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {() -> Void in
          // animate it to the identity transform (100% scale)
          self.backView.transform = CGAffineTransform.identity
          self.congratsView.transform = CGAffineTransform.identity
      }, completion: {(_ finished: Bool) -> Void in
          // if you want to do something once the animation finishes, put it here
          
        self.view?.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertClose(_:))))
          
          print("anime complete")
      })
      
  }
  
   //dissmiss alert and start new game
    @objc func alertClose(_ sender:AnyObject) {
      self.view!.superview!.gestureRecognizers?.removeAll()
          backView.removeFromSuperview()
          congratsView.removeFromSuperview()
          //reinitialize data & start new game
          print("Reinit game!")
          score = 0
          winner!.text = "\(score)/\(winScore)"
          selectedBackgroundIndex = selectedBackgroundIndex + 1
          if selectedBackgroundIndex == 3 {
            selectedBackgroundIndex = 0
          }
          background.texture = SKTexture(imageNamed: backgroundImageNames[selectedBackgroundIndex])
         
      }
  
  func didBegin(_ contact: SKPhysicsContact) {
    print(contact.bodyA) //Obviously this will be better in future, but I need to detect collision for a start
    print(contact.bodyB)
    
    if bottomFirstBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB || bottomSecondBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB || bottomThirdBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB || bottomFourthBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB {
        score = score + 1
        winner!.text = "\(score)/\(winScore)"
       //showScore(value: 1)
      if !checWinTheGame() {
        playSound(Resource:"click", Extension:"mp3")
      }
    }
    
    if topFirstBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB || topSecondBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB || topThirdBasket.physicsBody == contact.bodyA && ball.physicsBody == contact.bodyB{
        score = score + 2
        winner!.text = "\(score)/\(winScore)"
        //showScore(value: 2)
         if !checWinTheGame() {
           playSound(Resource:"click", Extension:"mp3")
         }
     }
   
  }
  
  func playSound(Resource:String, Extension:String) {
      
      guard let url = Bundle.main.url(forResource: Resource, withExtension: Extension) else {
          print("url not found")
          return
      }
      
      do {
          /// this codes for making this app ready to takeover the device audio
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
          try AVAudioSession.sharedInstance().setActive(true)
          
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
          player!.play()
      } catch let error as NSError {
          print("error: \(error.localizedDescription)")
      }
  }
  
  func collisionBetween(ball: SKNode, object: SKNode) {
      ball.removeFromParent()

  }

  func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
        let location = touch.location(in: self)
        if ball.contains(location) {
          ball.position = location
        }
      }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
        let location = touch.location(in: self)
        
        if ball.contains(location) {
          let p = CGPoint(x: location.x, y: ball.size.height / 2 + 20)
          ball.position = p
        }
      }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      ball.position.y += 5
      ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
      ball.physicsBody?.isDynamic = true
      ball.physicsBody?.collisionBitMask = 0
      ball.physicsBody?.usesPreciseCollisionDetection = true
      let animationDuration:TimeInterval = 1.5
      var actionArray = [SKAction]()
      actionArray.append(SKAction.move(to: CGPoint(x: ball.position.x, y: self.frame.size.height + 10), duration: animationDuration))
      actionArray.append(SKAction.removeFromParent())
      ball.run(SKAction.sequence(actionArray)) {
        self.setupBall()
      }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
  
}

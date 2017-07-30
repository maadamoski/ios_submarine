//
//  subemarineScene .swift
//  submarine
//
//  Created by PUCPR on 22/10/16.
//  Copyright © 2016 PUCPR. All rights reserved.
//

import SpriteKit
import AVFoundation


struct PhysicsCategory{
    static let Submarine : UInt32 = 0x1 << 0
    static let People : UInt32 = 0x1 << 1
}


class SubmarineScene : SKScene, SKPhysicsContactDelegate{
    
    var submarine = SKSpriteNode()
    var isFingeron = false
    let phrase = "Your Score: "
    var label:UILabel?
    var score:Int = 0
    var sound: AVAudioPlayer!
    var gravidade = 0
    
   //var collide:Bool  = false
    
    
    
    override func didMove(to view: SKView) {
       

        //score
     let label = UILabel(frame: CGRect(x: (self.view?.frame.size.width)! / 2 - 100, y: 100, width: 200, height: 20))
        label.textAlignment = .center
        label.text = "\(phrase) \(score)"
        self.view?.addSubview(label)
        self.label = label

        
        let meioX = self.size.width/2
        let meioY = self.size.height/2
        //posicao y do submarino
       let suby  = self.size.height * 0.2
        
       
        
        
        //background
        let background = SKTexture (imageNamed: "ocean2.png")
        
            //ampliar o background
        let tam1 = background.size().width * 1.3
        let tam2 = background.size().height * 1.3
        
        let back2 = SKSpriteNode(texture: background, size: CGSize(width: CGFloat(tam1), height: CGFloat(tam2)))
        back2.zPosition = -20
        back2.position.x = meioX
        back2.position.y = meioY
        self.addChild(back2)
        
        //submarine
        let sub  = SKTexture(imageNamed: "submarine.png")
        
            //reduzir img do submarino
        let sub1 = sub.size().width * 0.12
        let sub2 = sub.size().height * 0.15
        
        submarine = SKSpriteNode(texture: sub, size: CGSize(width: CGFloat(sub1), height: CGFloat(sub2)))
        submarine.zPosition = 0
        submarine.position.x = meioX
        submarine.position.y = suby
        self.addChild(submarine)
        
       //backgroundMusic
        let backgroundMusic = SKAudioNode(fileNamed: "game2f.mp3")
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        
        
        //física
        self.physicsWorld.gravity = CGVector (dx: 0, dy: -4)
       submarine.physicsBody = SKPhysicsBody(circleOfRadius: suby/4)
      //submarine.physicsBody = SKPhysicsBody(rectangleOf: subm.frame.size)
        submarine.physicsBody?.isDynamic = false
        submarine.physicsBody?.categoryBitMask = PhysicsCategory.Submarine
        submarine.physicsBody?.affectedByGravity = false
      //  subm.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsWorld.contactDelegate = self
        //queda dos magrinhos
        let fall = SKAction.sequence([SKAction.run(peoplefall), SKAction.wait(forDuration: 1.3)])
        self.run(SKAction.repeatForever(fall))
        
        //physicsWorld.contactDelegate = self
        submarine.physicsBody!.contactTestBitMask = PhysicsCategory.People
        
        
        
       // let backgroundMusic = SKAudioNode(fileNamed: "background-music-aac.caf")
       // backgroundMusic.autoplayLooped = true
        //addChild(backgroundMusic)
        
    }
    
    
 
    
    func peoplefall(){
        
       

      //  let meioX = self.size.width/2
//var randomX = CGFloat(Int(arc4random()) / meioX)
        let meioY = self.size.height/2
        
        
        //posicao magrinho em y
        //let teste = meioX * 0.2
        let peopley = meioY * 2

        //povo
        let people = SKTexture(imageNamed: "fallessa.png")
        let peop = people.size().width * 0.3
        let peo = people.size().height * 0.3
        
 
        
        
        
        let people2  = SKSpriteNode(texture: people, size: CGSize(width: CGFloat(peop), height: CGFloat(peo)))
        people2.name = "people2"
        
        let min = people2.size.width/2
        let max = self.size.width - people2.size.width/2
        let positionx = CGFloat(arc4random()) / 0xFFFFFFFF * (max-min) + min
        
        people2.zPosition = 0
        //people2.position.x = postionx
        people2.position = CGPoint(x: positionx, y: peopley)
    //    people2.position.y = peopley
        self.addChild(people2)
        
        people2.physicsBody = SKPhysicsBody(rectangleOf: people2.frame.size)
        people2.physicsBody!.isDynamic = true
        people2.physicsBody!.categoryBitMask = PhysicsCategory.People
        people2.physicsBody!.affectedByGravity = true
        people2.physicsBody!.collisionBitMask = PhysicsCategory.Submarine
        people2.physicsBody!.contactTestBitMask = PhysicsCategory.Submarine
       
        
    }
    //func didCollide(submarine: SKSpriteNode, people: SKNode){
      //  people.removeFromParent()
        
      //  self.removeChildren(in: [people])
    //}
    
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            
        }
       // print("bolo")
      //  print(firstBody.categoryBitMask)
        //print(secondBody.categoryBitMask)

        
        if (firstBody.categoryBitMask == PhysicsCategory.Submarine &&
            secondBody.categoryBitMask == PhysicsCategory.People){
            //didCollide(submarine: firstBody.node as!SKSpriteNode, people: secondBody.node as! SKNode)
        
            //collision sound
            let path = Bundle.main.path(forResource: "entrando.wav", ofType: nil)!
            let url = URL(fileURLWithPath: path)
            do{
                let soundcollision = try AVAudioPlayer(contentsOf: url)
                
               
                
                
                sound = soundcollision
                sound.play()
                
            }catch{
                
            }
          /*  let collisionsound = SKAudioNode(fileNamed: "entrando.wav")
            collisionsound.autoplayLooped = true
            self.addChild(collisionsound)*/
            
            
            
            
            score += 1
                
            //    print(score)
            
         
          label?.text = "\(phrase) \(score)"
            self.view?.addSubview(label!)
         

            self.removeChildren(in: [secondBody.node!])
            
            
            
        }
        else{
            
        }
        
    }
    
    
    
    override func didEvaluateActions() {
        self.enumerateChildNodes(withName: "people2", using:
            {
                (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if(node.position.y<0){
                    //gameover sound
                    let gameover = SKAudioNode(fileNamed: "overf.wav")
                    gameover.autoplayLooped = true
                    self.addChild(gameover)
                    sleep(5)
                    
                    
                    node.removeFromParent()
                    let menuscene = MenuScene(size: self.size)
                    self.view?.presentScene(menuscene)
                   
                    self.label?.removeFromSuperview()

                    
                }
                
        })
    }
  
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if let body = physicsWorld.body(at: touchLocation) {
            if (body.node!.name == submarine.name ){
                
                isFingeron = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isFingeron {
            
            let touch = touches.first
            let touchLocation = touch!.location(in: self)
            let previousLocation = touch!.previousLocation(in: self)
          
          let s =  submarine
            
            var sX = s.position.x + (touchLocation.x - previousLocation.x)
           
            sX = max(sX, s.size.width/2)
            sX = min(sX, size.width - s.size.width/2)
          
            s.position = CGPoint(x: sX, y: s.position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isFingeron = false
    }
    
    
    
    
    
    
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
       /* if (score)
        if (score%10==0){
            
            gravidade -= 1
            self.physicsWorld.gravity = CGVector (dx: 0, dy: gravidade )
            print(gravidade)
        }*/

    }
}

//
//  GameViewController.swift
//  submarine
//
//  Created by PUCPR on 22/10/16.
//  Copyright © 2016 PUCPR. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
   // let phrase = "Your Score: "
    //var label:UILabel?
     //var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let myview = self.view as! SKView?
        let scene = MenuScene(size: self.view.bounds.size)
        
        //let scene = SubmarineScene(size: self.view.bounds.size)
        scene.scaleMode = .aspectFill
        myview?.presentScene(scene)
        
        myview?.showsFPS = true
        myview?.showsNodeCount = true
        myview?.showsPhysics = true
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

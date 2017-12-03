//
//  ViewController.swift
//  GameCenter
//
//  Created by Dai Haneda on 2017/12/03.
//  Copyright © 2017年 Dai Haneda. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate {
  
  var score: Int = 0
  
  @IBOutlet weak var scoreLbl: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    authPlayer()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func addScore(_ sender: Any) {
    score += 1
    scoreLbl.text = "\(score)"
  }
  
  @IBAction func callGC(_ sender: Any) {
    saveHighScore(number: score)
    showReaderBoard()
  }
  
  func authPlayer() {
    let localPlayer = GKLocalPlayer.localPlayer()
    localPlayer.authenticateHandler = {
      (view, error) in
      if view != nil {
        self.present(view!, animated: true, completion: nil)
      }
      else {
        print(GKLocalPlayer.localPlayer().isAuthenticated)
      }
      
    }
  }
  
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
  
  func saveHighScore(number: Int) {
    if GKLocalPlayer.localPlayer().isAuthenticated {
      let scoreReporter = GKScore(leaderboardIdentifier: "test")
      scoreReporter.value = Int64(number)
      let scoreArray: [GKScore] = [scoreReporter]
      GKScore.report(scoreArray, withCompletionHandler: nil)
    }
  }

  func showReaderBoard(){
    let viewController = self.view.window?.rootViewController
    let gcVC = GKGameCenterViewController()
    
    gcVC.gameCenterDelegate = self
    viewController?.present(gcVC, animated: true, completion: nil)
    
  }
}


//
//  RoundViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController {
  var timer: Timer
  var matchTime: Int = 8 * 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if DataManager.shared.user.spy {
      // User is the spy
      locationLabel.text = "Location: ???"
      roleLabel.text = "You are the spy!"
      
    } else {
      // User is not the spy
      locationLabel.text = DataManager.shared.match.locationID
      roleLabel.text = DataManager.shared.user.role
      
    }
    
    // Subtract any lost seconds due to calculation from match time
    matchTime  = matchTime - DataManager.shared.match.secsLostSinceStart()
    
    fireTimer()
    
  }
  
  func fireTimer() {
    if timer.isValid {
      timer.invalidate()
    }
    
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RoundViewController.runTimer), userInfo: nil, repeats: true)
  }
  
  func runTimer() {
    
    if DataManager.shared.match.status == 1 {
      // Check match status = 1 so it should be incrementing timer
      
      matchTime -= 1
      let totalSecs = matchTime
      
      let mins = floor(Double(totalSecs / 60))
      let secs = totalSecs % 60
      
      timerLabel.text = String(format: "%02d", Int(mins)) + ":" + String(format: "%02d", Int(secs))
      
    }
    
  }
  
  func updateUI() {
    let status = DataManager.shared.match.status
    
    if status == 1 {
      // Status = normal; continue Round as usual
      
      
    } else {
      // Game isn't in standard Round status; check to see which one and act accordingly
      
      if status == 0 {
        // Need to return to lobby
        performSegue(withIdentifier: "segueBackToLobby", sender: self)
        
      } else if status == 2 {
        // Premature voting
        
      } else if status == 3 {
        // Match ended; doing 1 min of voting
        
      } else if status == 4 {
        // Match ended; voting failed; spy guessing
        
        if DataManager.shared.user.spy == true {
          // Initiate guessing stuff for spy
          
        } else {
          // Display that Spy is guessing
          
        }
        
      } else if status == 5 {
        // Match over; closing game
        performSegue(withIdentifier: "segueBackToLobby", sender: self)
        
      } else {
        // Error; status is invalid
        print("FATAL ERROR: INVALID STATUS")
        DataManager.shared.match.leave()
        performSegue(withIdentifier: "segueBackToMenu", sender: self)
        
      }
      
      
    }
    
    
    
  }
  
  @IBAction func clickExit(_ sender: Any) {
    if DataManager.shared.user.host {
      // User is host
      print("Host is ending match")
      DataManager.shared.match.end()
      print("Returning to lobby")
      performSegue(withIdentifier: "segueBackToLobby", sender: self)
      
    } else {
      // User is a player
      print("User is leaving match")
      DataManager.shared.match.leave()
      
      print("Returning to menu")
      performSegue(withIdentifier: "segueBackToMenu", sender: self)
      
      
    }
    
    
    
    
  }
  
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var roleLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  
}

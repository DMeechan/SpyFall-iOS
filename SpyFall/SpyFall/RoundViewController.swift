//
//  RoundViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController {
  var timer: Timer = Timer()
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
    
    updateUI()
    
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
      reloadTables()
      
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
  
  func reloadTables() {
    print("Reloading player table data")
    playersTableLeft.reloadData()
    playersTableRight.reloadData()
    
    print("Reloading loction table data")
    locationsTableLeft.reloadData()
    locationsTableRight.reloadData()
    
  }
  
  @IBAction func clickExit(_ sender: Any) {
    if DataManager.shared.user.host {
      // User is host
      print("Host is ending match")
      DataManager.shared.match.close()
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
  
  // MARK: Managing TableViews
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Evaluating table")
    
    if tableView == self.playersTableLeft || tableView == self.playersTableRight {
      // Use player cells
      print("-> Using player table")
      
      let cellIdentifier = "PlayerRoundTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerRoundTableViewCell else {
        fatalError("The dequeued cell is not an instance of PlayerRoundTableViewCell")
      }
      
      let player = DataManager.shared.match.players[indexPath.row]
      
      cell.nameLabel?.text = player.name
      
      return cell
      
    } else if tableView == self.locationsTableLeft || tableView == self.locationsTableRight {
      // Use location cells
      print("-> Using location table")
      
      let cellIdentifier = "LocationRoundTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationRoundTableViewCell else {
        fatalError("The dequeued cell is not an instance of LocationRoundTableViewCell")
      }
      
      let location = Location.shared[indexPath.row]
      
      cell.nameLabel?.text = location.name
      
      return cell
      
    } else {
      print("FATAL ERROR: TableView not recognised in RoundView: ", tableView)
      let cell = UITableViewCell()
      return cell
      
    }
    
    
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("Checking table count")
    if tableView == self.playersTableLeft {
      print("-> Using player table left")
      return DataManager.shared.match.players.count / 2
      
    } else if tableView == self.playersTableRight {
      // Use floor to round it down; so if the player count is odd, it will output the correct amount
      print("-> Using player table right")
      return Int(floor(Double(DataManager.shared.match.players.count / 2)))
      
    } else if tableView == self.locationsTableLeft {
      print("-> Using location table left")
      return Location.shared.count / 2
      
    } else if tableView == self.locationsTableRight {
      // Use floor to round it down; so if the location count is odd, it will output the correct amount
      print("-> Using location table right")
      return Int(floor(Double(Location.shared.count / 2)))
      
    } else {
      print("FATAL ERROR: Using invalid TableView: ", tableView)
      return 1
      
    }
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    print("Outputting num of table sections")
    return 1
    
  }
  
  @IBOutlet weak var playersTableLeft: UITableView!
  @IBOutlet weak var playersTableRight: UITableView!
  
  @IBOutlet weak var locationsTableLeft: UITableView!
  @IBOutlet weak var locationsTableRight: UITableView!
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var roleLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  
}

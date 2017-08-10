//
//  RoundViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
      locationLabel.text = "Location: " + DataManager.shared.match.locationID
      roleLabel.text = "Your role: " + DataManager.shared.user.role
      
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
      
      if totalSecs == 0 {
        // Timer has reached 0!
        // TODO: Time to change game status?
        timer.invalidate()
        
      }
      
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
  
  // MARK: Managing TableViews
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("SUCCESS: Evaluating table")
    
    if tableView == self.playersTableLeft || tableView == self.playersTableRight {
      // Use player cells
      print("-> Using player table")
      
      let cellIdentifier = "PlayerRoundTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerRoundTableViewCell else {
        fatalError("The dequeued cell is not an instance of PlayerRoundTableViewCell")
      }
      
      var pos: Int = 0
      
      if tableView == self.playersTableLeft {
        // Left side
        pos = indexPath.row
        
      } else {
        // Right side
        // Need to add players.count / 2 to it so it outputs the right side differently to left
        
        pos = indexPath.row + roundInt(roundUp: true, array: DataManager.shared.match.players, dividor: 2.0)
        print("IndexPath row is: \(indexPath.row) and final pos value is: \(pos)")
        
      }
      
      let player = DataManager.shared.match.players[pos]
      cell.nameLabel?.text = player.name
      
      return cell
      
    } else if tableView == self.locationsTableLeft || tableView == self.locationsTableRight {
      // Use location cells
      print("-> Using location table")
      
      let cellIdentifier = "LocationRoundTableViewCell"
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LocationRoundTableViewCell else {
        fatalError("The dequeued cell is not an instance of LocationRoundTableViewCell")
      }
      
      var pos: Int = 0
      
      if tableView == self.locationsTableLeft {
        // Left side
        pos = indexPath.row
        
      } else {
        // Right side
        // Need to add players.count / 2 to it so it outputs the right side differently to left
        
        pos = indexPath.row + roundInt(roundUp: true, array: Location.shared, dividor: 2.0)
        print("IndexPath row is: \(indexPath.row) and final pos value is: \(pos)")
        
      }
      
      let location = Location.shared[pos]
      cell.nameLabel?.text = location.name
      
      return cell
      
    }
    
    print("FATAL ERROR: TableView not recognised in RoundView: ", tableView)
    let cell = UITableViewCell()
    return cell
    
    
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("Checking table count...")
    if tableView == self.playersTableLeft {
      print("-> Using player table left")
      
      let output:Int = roundInt(roundUp: true, array: DataManager.shared.match.players, dividor: 2.0)
      print("-> Outputting: \(output)")
      return output
      
    } else if tableView == self.playersTableRight {
      // Use floor to round it down; so if the player count is odd, it will output the correct amount
      print("-> Using player table right")
      
      let output:Int = roundInt(roundUp: false, array: DataManager.shared.match.players, dividor: 2.0)
      print("-> Outputting: \(output)")
      return output
      
    } else if tableView == self.locationsTableLeft {
      print("-> Using location table left")
      
      let output:Int = roundInt(roundUp: true, array: Location.shared, dividor: 2.0)
      print("-> Outputting: \(output)")
      return output
      
    } else if tableView == self.locationsTableRight {
      // Use floor to round it down; so if the location count is odd, it will output the correct amount
      print("-> Using location table right")
      
      let output:Int = roundInt(roundUp: true, array: Location.shared, dividor: 2.0)
      print("-> Outputting: \(output)")
      return output
      
    } else {
      print("FATAL ERROR: Using invalid TableView: ", tableView)
      return 1
      
    }
    
  }
  
  func roundInt(roundUp: Bool, array: [AnyObject], dividor: Double) -> Int {
    
    if roundUp {
      // Round up
      return Int(round(Double(array.count) / dividor))
      
    } else {
      // Round down
      return Int(floor(Double(array.count) / dividor))
      
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    print("Outputting num of table sections")
    return 1
    
  }
  
  // MARK: Manage UI elements
  
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
  
  @IBAction func clickInfoToggle(_ sender: Any) {
    // Hiding player info
    
    if locationLabel.isHidden {
      
      UIView.animate(withDuration: 0.2, animations:  {
        self.locationLabel.isHidden = false
        self.roleLabel.isHidden = false
        
        self.infoToggleButton.transform = CGAffineTransform(rotationAngle: (360.0 * CGFloat(Double.pi)) / 180.0)
      })
      
    } else {
      
      UIView.animate(withDuration: 0.2, animations:  {
        self.locationLabel.isHidden = true
        self.roleLabel.isHidden = true
        
        self.infoToggleButton.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
      })
      
    }
    
    
  }
  
  
  @IBAction func clickPlayersToggle(_ sender: Any) {
    // Hiding players list
    
    if playersTableLeft.isHidden {
      
      UIView.animate(withDuration: 0.2, animations:  {
        self.playersTableLeft.isHidden = false
        self.playersTableRight.isHidden = false
        self.playersSeparator.isHidden = false
        
        self.playersToggleButton.transform = CGAffineTransform(rotationAngle: (360.0 * CGFloat(Double.pi)) / 180.0)
      })
      
    } else {
      
      UIView.animate(withDuration: 0.2, animations:  {
        self.playersTableLeft.isHidden = true
        self.playersTableRight.isHidden = true
        self.playersSeparator.isHidden = true
        
        self.playersToggleButton.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
      })
      
    }
  }
  
  @IBAction func clickLocationsToggle(_ sender: Any) {
    // Hiding locations list
    
    if locationsTableLeft.isHidden {
      
      UIView.animate(withDuration: 0.2, animations:  {
        self.locationsTableLeft.isHidden = false
        self.locationsTableRight.isHidden = false
        self.locationsSeparator.isHidden = false
        
        self.locationsToggleButton.transform = CGAffineTransform(rotationAngle: (360.0 * CGFloat(Double.pi)) / 180.0)
      })
      
    } else {

      UIView.animate(withDuration: 0.2, animations:  {
        self.locationsTableLeft.isHidden = true
        self.locationsTableRight.isHidden = true
        self.locationsSeparator.isHidden = true
        
        self.locationsToggleButton.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
      })
      
    }
  }
  
  @IBOutlet weak var infoToggleButton: UIButton!
  @IBOutlet weak var playersToggleButton: UIButton!
  @IBOutlet weak var locationsToggleButton: UIButton!
  
  @IBOutlet weak var playersTableLeft: UITableView!
  @IBOutlet weak var playersTableRight: UITableView!
  @IBOutlet weak var playersSeparator: UIView!
  
  @IBOutlet weak var locationsTableLeft: UITableView!
  @IBOutlet weak var locationsTableRight: UITableView!
  @IBOutlet weak var locationsSeparator: UIStackView!
  
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var roleLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  
  
}

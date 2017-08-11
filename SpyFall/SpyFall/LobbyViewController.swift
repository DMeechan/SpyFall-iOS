//
//  LobbyViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var userIsHost: Bool = false
  let match = DataManager.shared.match
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let addFakePlayers = false
    
    if userIsHost && addFakePlayers {
      match.add(player: Player(name: "Temp1"), host: false)
      match.add(player: Player(name: "Temp2"), host: false)
      match.add(player: Player(name: "Temp3"), host: false)
      match.add(player: Player(name: "Temp4"), host: false)
      match.add(player: Player(name: "Temp5"), host: false)
      match.add(player: Player(name: "Temp6"), host: false)
      match.add(player: Player(name: "Temp7"), host: false)
      
      for player in match.players {
        player.ready = true
      }
      
      DataManager.shared.write()
      
    } else if !userIsHost {
      // User needs to get added to the game
      DataManager.shared.checkForDuplicateUser()
      DataManager.shared.writeUser()
      
    }
    
    DataManager.shared.match.listPlayers()
    
    // DataManager.shared.write()
    
    if userIsHost {
      DataManager.shared.read()
    }
    
    updateUI()
    
    
    // Do any additional setup after loading the view.
  }

  
  // MARK: User interface
  
  func updateUI() {
    
    // Update players table
    self.playersTableView.reloadData()
    
    // Update match status
    if match.status == 1 {
      // Match has now moved to Round phase
      DataManager.shared.getUser()
      switchToRoundView()
      
    } else if match.status > 1 {
      print("Error, should not be in lobby if game status > 1")
      
    }
    
    gameIDLabel?.text = "Game ID: \(match.ID)"
    
    if allPlayersReady() {
      gameStatusLabel.text = "Waiting for host to start..."
      
    } else {
      gameStatusLabel.text = "Waiting for players to ready up..."
      
    }
    
    // Check if the user needs to start the game or not (if they're host)
    if userIsHost {
      // User is host, so may need to start the game
      
      if allPlayersReady() {
        // Nope, players aren't ready
        actionButton?.setTitle("START GAME", for: .normal)
        
      } else {
        actionButton.setTitle("PLAYERS NOT YET READY", for: .normal)
      }
      
    } else {
      // User is a standard player who needs to ready up
      
      if DataManager.shared.user.ready {
        // User is ready
        actionButton.setTitle("READY", for: .normal)
        
      } else {
        // User is not ready
        actionButton.setTitle("CLICK TO READY UP", for: .normal)
        
      }
      
    }
    
  }
  
  func switchToRoundView() {
    performSegue(withIdentifier: "segueToRound", sender: self)
  }
  
  func allPlayersReady() -> Bool {
    for player in match.players {
      if player.ready == false {
        return false
      }
    }
    
    return true
  }
  
  func startGame() {
    match.start()
    // performSegue(withIdentifier: "", sender: self)
    
  }
  
  // MARK: Manage Players TableView
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "PlayerTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerTableViewCell else {
      fatalError("The dequeued cell is not an instance of PlayerTableViewCell")
    }
    
    let player = match.players[indexPath.row]
    print("Table looking at player: \(player.name)")
    
    cell.nameLabel?.text = player.name
    
    if player.ready {
      cell.readyImage.image = UIImage(named: "tick")
    } else {
      cell.readyImage.image = UIImage(named: "cross")
    }
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return match.players.count
    
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
    
  }

  
  
  // MARK: Extra stuff
  
  
  @IBAction func clickActionButton(_ sender: Any) {
    if userIsHost {
      if allPlayersReady() {
        // Players are ready
        startGame()
        
      }
      
    } else {
      // User is a normal player
      // So inverse their ready status for clicking the button
      DataManager.shared.user.ready = !DataManager.shared.user.ready
      DataManager.shared.writeUser()
    }
    
  }
  
  @IBAction func clickExit(_ sender: Any) {
    if userIsHost {
      DataManager.shared.match.close()
      
    } else {
      DataManager.shared.match.leave()
      
    }
    
    performSegue(withIdentifier: "segueToMenu", sender: self)
    
  }
  
  @IBAction func clickShareGameID(_ sender: Any) {
    
  }
  
  @IBOutlet weak var gameStatusLabel: UILabel!
  @IBOutlet weak var gameIDLabel: UILabel!
  @IBOutlet weak var actionButton: SquareButton!
  
  @IBOutlet weak var playersTableView: UITableView!
  
}

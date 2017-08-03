//
//  MenuViewController.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  var hostingGame: Bool = false
  var user: Player = Player(name: "Jim")
  var gameIDToJoin = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    resetJoinGameButton()
    
    // Import locations
    Location.getSampleLocations()
    
  }
  
  func createGame() {
    // Switch to lobby
    hostingGame = true
    DataManager.shared.match = Match(host: user)
    performSegue(withIdentifier: "segueToLobby", sender: self)
    
  }
  
  func joinGame() {
    // Reset Match data every time Menu is loaded
    DataManager.shared.match = Match()
    joinGameButton.setTitle("FINDING GAME...", for: .normal)
    joinGameButton.isEnabled = false
    
    // Join game if the access code is right
    gameIDToJoin = "9264"
    DataManager.shared.read(gameID: gameIDToJoin)
    
    Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.joinGameIfExists), userInfo: nil, repeats: false)
    
  }
  
  func joinGameIfExists() {
    print("DataManager Match Players:")
    print(DataManager.shared.match.players.count)
    
    resetJoinGameButton()
    
    if DataManager.shared.match.ID != "" {
      // Match exists - let's join!
      joinGameButton.setTitle("JOINING...", for: .normal)
      performSegue(withIdentifier: "segueToLobby", sender: self)
      
    } else {
      joinGameButton.setTitle("GAME NOT FOUND", for: .normal)
      Timer.scheduledTimer(timeInterval: 2, target:self, selector: #selector(self.resetJoinGameButton), userInfo: nil, repeats: false)
      
    }
    
    
  }
  
  func resetJoinGameButton() {
    joinGameButton.isEnabled = true
    joinGameButton.setTitle("JOIN GAME", for: .normal)
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let lobby = segue.destination as! LobbyViewController
    
    // Pass lobby to DataManager so it can update the player table
    DataManager.shared.lobbyViewRef = lobby
    
    // Get the lobby set up with the right data
    lobby.user = self.user
    lobby.userIsHost = hostingGame
    
  }
  
  // MARK: Extra stuff
  
  @IBAction func clickCreateGame(_ sender: Any) {
    createGame()
  }
  
  @IBOutlet weak var joinGameButton: SquareButton!
  
  @IBAction func clickJoinGame(_ sender: Any) {
    joinGame()
  }
  
}

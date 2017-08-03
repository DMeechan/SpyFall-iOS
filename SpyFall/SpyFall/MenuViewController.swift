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
  var match: Match?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    Location.getSampleLocations()
    hostingGame = false
    
    // Do any additional setup after loading the view.
  }
  
  func createGame() {
    //LobbyViewController.match = Match()
    hostingGame = true
    match = Match(host: user)
    performSegue(withIdentifier: "segueToLobby", sender: self)
  }
  
  func joinGame() {
    
    performSegue(withIdentifier: "segueToLobby", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let lobby = segue.destination as! LobbyViewController
    
    lobby.user = self.user
    lobby.userIsHost = hostingGame
    
    if hostingGame {
      print("Hosting game")
      lobby.match = self.match
      
    } else {
      print("Joining game")
      lobby.match = DataManager.shared.read(accessCode: "6298")
      
    }
    
  }
  
  // MARK: Extra stuff
  
  @IBAction func clickCreateGame(_ sender: Any) {
    createGame()
  }
  
  @IBAction func clickJoinGame(_ sender: Any) {
    joinGame()
  }
  
}

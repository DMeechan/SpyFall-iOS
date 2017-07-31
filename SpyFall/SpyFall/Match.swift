//
//  Player.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation


class Match {
  var status: Int = 0
  var accessCode: String = ""
  var location: Location = Location()
  var players: [Player] = [Player]()
  var timer: Timer = Timer()
  
  // For status:
    // 0 = lobby (waiting for players)
    // 1 = lobby (waiting for host)
    // 2 = room (playing)
    // 3 = room (match ended; in 1 min voting)
    // 4 = room (match ended; voting failed; spy is guessing location)
    // 5 = match over; closing game
  
  init(host: Player) {
    self.accessCode = generateAccessCode()
    self.location = chooseLocation()
    // self.timer = Timer()
    
    add(player: host, isHost: true)
    
  }
  
  func add(player: Player, isHost: Bool) {
    player.isSpy = false
    player.isFirstToAsk = false
    player.role = ""
    
    if isHost {
      player.isReady = true
      player.isHost = true
      
    } else {
      player.isReady = false
      player.isHost = false
      
    }
    
    players.append(player)
  }
  
  func start() {
    self.status = 3
    // TODO: Update status - make sure it's correct
    
    // Add each player to the unassignedPlayers array
    var unassignedPlayers = [Player]()
    for player in players {
      unassignedPlayers.append(player)
    }
    
    // Set one as the spy and remove them from the array
    let spy:Int = Int(arc4random_uniform(UInt32(players.count)))
    players[spy].isSpy = true
    unassignedPlayers.remove(at: spy)
    
    // Go through and assign each player (except spy) a random role
    var i = 0
    while unassignedPlayers.count > 0 {
      let random:Int = Int(arc4random_uniform(UInt32(unassignedPlayers.count)))
      unassignedPlayers[random].role = location.roles[i]
      i += 1
      unassignedPlayers.remove(at: random)
    }
    
    // If fewer roles have been given out than there are players (excl. spy ofc), then big error potentially
    if i < (players.count - 1) {
      print("FATAL ERROR: only was able to give out \(i + 1) roles (i = \(i) to \(players.count) players!)")
    }
    
  }
  
  func listPlayers() {
    print("Players in match \(accessCode):")
    for player in players {
      print("  \(player.name) - isHost: \(player.isHost), isReady: \(player.isReady), isFirstToAsk: \(player.isFirstToAsk), role: \(player.role)")
    }
    
  }
  
  func generateAccessCode() -> String {
    let random:Int = Int(arc4random_uniform(10000))
    
    let formatted: String = (String(format: "%04d", random))
    print("Game access code: \(formatted)")
    
    return formatted
    
  }
  
  func chooseLocation() -> Location {
    let random:Int = Int(arc4random_uniform(UInt32(Location.shared.count)))
    
    return Location.shared[random]
    
  }
  
}



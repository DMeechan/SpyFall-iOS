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
  var locationID: String = ""
  var players: [Player] = [Player]()
  var startTime: Int = 0
  
  // For status:
    // 0 = lobby (waiting for players)
    // 1 = lobby (waiting for host)
    // 2 = room (playing)
    // 3 = room (match ended; in 1 min voting)
    // 4 = room (match ended; voting failed; spy is guessing location)
    // 5 = match over; closing game
  
  init(host: Player) {
    self.accessCode = generateAccessCode()
    self.locationID = chooseLocation().name
    // self.timer = Timer()
    
    add(player: host, isHost: true)
    
  }
  
  func add(player: Player, isHost: Bool) {
    player.isSpy = false
    player.vote = ""
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
    
    // Find Location object
    var found: Bool = false
    var i = 0
    var location: Location?
    while found == false || i == Location.shared.count {
      if Location.shared[i].name == locationID {
        location = Location.shared[i]
        found = true
      }
      i += 1
    }
    
    // Go through and assign each player (except spy) a random role
    while unassignedPlayers.count > 0 {
      let random:Int = Int(arc4random_uniform(UInt32(unassignedPlayers.count)))
      
      unassignedPlayers[random].role = (location?.roles[i])!
      
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
      print("  \(player.name) - isHost: \(player.isHost), isReady: \(player.isReady), role: \(player.role), vote: \(player.vote)")
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
  
  func toDictionary() -> [String:AnyObject] {
    let dict: [String: AnyObject] = [
      "status" : self.status as AnyObject,
      "accessCode" : self.accessCode as AnyObject,
      "locationID" : self.locationID as AnyObject,
      "players" : self.playersToDictionary() as AnyObject,
      "startTime" : self.startTime as AnyObject
      
    ]
    
    return dict
    
  }
  
  func fromDictionary(dict: [String: AnyObject]) {
    self.status = dict["status"] as! Int
    self.accessCode = dict["accessCode"] as! String
    self.locationID = dict["locationID"] as! String
    self.players = playersFromDictionary(dict: dict["players"] as! [String: AnyObject])
    self.startTime = dict["startTime"] as! Int
    
  }
  
  func playersFromDictionary(dict: [String: AnyObject]) -> [Player] {
    var players = [Player]()
    
    var i = 0
    while i < dict.count {
      let player = Player(name: "")
      
      if let dictVal = dict["player\(i)"] {
        player.fromDictionary(dict: dictVal as! [String : AnyObject])
        players.append(player)
        
      } else {
        print("ERROR: Players dictionary from Firebase contains invalid key (it's not players[int])!")
        
      }
      
      i += 1
    }
    
    return players
    
  }
  
  func playersToDictionary() -> [String: AnyObject] {
    var dict: [String: AnyObject] = [:]
    
    var i = 0
    while i < self.players.count {
      dict["player\(i)"] = players[i].toDictionary() as AnyObject
      i += 1
    }
    
    return dict
    
  }
  
}


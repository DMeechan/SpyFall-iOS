//
//  Player.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

class Player {
  let name: String
  var isHost: Bool = false
  var isSpy: Bool = false
  var isReady: Bool = false
  var isFirstToAsk: Bool = false
  var role: String = ""
  
  init(name: String) {
    self.name = name
    
  }
    
}

class Match {
  var status: Int = 0
  var accessCode: Int = 0
  var location: Location = Location()
  var players: [Player] = [Player]()
  var timer: Timer = Timer()
  
  // For status:
    // 0 = lobby
    // 1 = room (playing)
    // 2 = room (match ended; in 1 min voting)
    // 3 = room (match ended; voting failed; spy is guessing location)
    // 4 = match over; closing game
  
  init(host: Player) {
    self.accessCode = generateAccessCode()
    self.location = generateLocation()
    self.timer = Timer()
    
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
    self.status = 1
    
    // Add each player to the unassignedPlayers array
    var unassignedPlayers = [Player]()
    for player in players {
      unassignedPlayers.append(player)
    }
    
    // Set one as the spy and remove them from the array
    let spy:Int = Int(arc4random_uniform(UInt32(players.count)))
    players[spy].isSpy = true
    unassignedPlayers.remove(at: spy)
    
    var i = 0
    while unassignedPlayers.count > 0 {
      let random:Int = Int(arc4random_uniform(UInt32(unassignedPlayers.count)))
      unassignedPlayers[random].role = location.roles[i]
      i += 1
      unassignedPlayers.remove(at: random)
    }
    
    
    //if i < (players.count - 1) {
      //print("FATAL ERROR: only was able to give out \(i + 1) roles (i = \(i) to \(players.count) players!)")
    //}
    
  }
  
  func generateAccessCode() -> Int {
    let random:Int = Int(arc4random_uniform(10000))
    
    let formatted: String = (String(format: "%04d", random))
    let formattedRandom: Int = Int(formatted)!
    
    print("Game access code: \(formattedRandom)")
    
    return formattedRandom
  }
  
  func generateLocation() -> Location {
    
    return Location()
  }
  
}

class Location {
  var name: String = ""
  var roles: [String] = [String]()
  
  static var shared = [Location]()
  
  init() {
    name = ""
    roles = [String]()
    
  }
  
  init(name: String, roles: [String]) {
    self.name = name
    self.roles = roles
    
  }
  
  func getSampleLocations() -> [Location] {
    var locations = [Location]()
    locations.append(Location(name: "location1", roles: ["apple", "bee", "can"]))
    locations.append(Location(name: "location2", roles: ["dog", "cat", "fox"]))
    locations.append(Location(name: "location3", roles: ["coke", "pepsi", "dr pepper"]))
    
    return locations

  }
  
}

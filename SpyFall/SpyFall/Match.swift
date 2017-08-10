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
  var ID: String = ""
  var locationID: String = ""
  var players: [Player] = [Player]()
  var startTime: Int = 0
  var firstToAsk: String = ""
  
  // For status:
  // 0 = lobby (waiting)
  // 1 = room (playing)
  // 2 = room (premature voting)
  // 3 = room (match ended; in 1 min voting)
  // 4 = room (match ended; voting failed; spy is guessing location)
  // 5 = match over; closing game
  
  init(host: Player) {
    self.ID = generateID()
    self.locationID = chooseLocation().name
    // self.timer = Timer()
    
    add(player: host, host: true)
    
  }
  
  init() {
    
  }
  
  func add(player: Player, host: Bool) {
    player.spy = false
    player.vote = ""
    player.role = ""
    
    if host {
      player.ready = true
      player.host = true
      
    } else {
      player.ready = false
      player.ready = false
      
    }
    
    players.append(player)
  }
  
  func start() {
    self.status = 1
    // TODO: Update status - make sure it's correct
    
    // Add each player to the unassignedPlayers array
    var unassignedPlayers = [Player]()
    for player in players {
      unassignedPlayers.append(player)
    }
    
    // Set one as the spy and remove them from the array
    let spy:Int = Int(arc4random_uniform(UInt32(players.count)))
    players[spy].spy = true
    unassignedPlayers.remove(at: spy)
    
    // Find Location object in array
    var found: Bool = false
    var locationIndex = 0
    var location: Location?
    while found == false && locationIndex < Location.shared.count {
      if Location.shared[locationIndex].name == locationID {
        location = Location.shared[locationIndex]
        found = true
      }
      locationIndex += 1
    }
    
    // Go through and assign each player (except spy) a random role
    var roleIndex = 0
    while unassignedPlayers.count > 0 {
      let random:Int = Int(arc4random_uniform(UInt32(unassignedPlayers.count)))
      
      unassignedPlayers[random].role = (location?.roles[roleIndex])!
      
      roleIndex += 1
      unassignedPlayers.remove(at: random)
    }
    
    // If fewer roles have been given out than there are players (excl. spy ofc), then big error potentially
    if roleIndex < (players.count - 1) {
      print("FATAL ERROR: only was able to give out \(roleIndex + 1) roles (i = \(roleIndex) to \(players.count) players!)")
    }
    
    // Find start time of match in milliseconds
    let startDate = Date()
    
    // Need to *1000 because it's in seconds by default
    let startDateInMilliseconds = startDate.timeIntervalSince1970 * 1000
    
    self.startTime = Int(startDateInMilliseconds)
    
    DataManager.shared.write()
    
  }
  
  func secsLostSinceStart() -> Int {
    
    // TODO: Client timer delays
    // Currently there's a ~0.5 second delay between clients' timers
    // While this delay isn't ideal, the current solution is probably-
    // -better than polling Firebase every second for timer updates!
    // So will keep it for now
    // I've done some checking in Playground, and this secsLostSinceStart()-
    // -function seems to work perfectly, so the problem likely lies elsewhere
    
    // All done in seconds with milliseconds in decimal places
    let startTimeSecs = Double(self.startTime) / 1000
    
    let currentDate = Date()
    let currentTimeSecs = currentDate.timeIntervalSince1970
    
    let timeLost = currentTimeSecs - startTimeSecs
    
    // Now convert to pure int seconds
    let timeLostInt = Int(timeLost)
    
    print("Time lost since match start: \(timeLostInt)")
    return timeLostInt
    
  }
  
  func close() {
    self.status = 0
    for player in players {
      player.spy = false
      player.role = ""
      
      
      if player.host {
        player.ready = true
        
      } else {
        player.ready = false
      }
      
    }
    
    DataManager.shared.write()
    
  }

  
  func leave() {
    DataManager.shared.removeUser()
    
  }
  
  func listPlayers() {
    print("Players in match \(ID):")
    for player in players {
      print("  \(player.name) - host: \(player.host), ready: \(player.ready), role: \(player.role), vote: \(player.vote)")
    }
    
  }
  
  func generateID() -> String {
    let random:Int = Int(arc4random_uniform(10000))
    
    let formatted: String = (String(format: "%04d", random))
    print("Game ID: \(formatted)")
    
    return formatted
    
  }
  
  func chooseLocation() -> Location {
    let random:Int = Int(arc4random_uniform(UInt32(Location.shared.count)))
    
    return Location.shared[random]
    
  }
  
  func toDictionary() -> [String:AnyObject] {
    let dict: [String: AnyObject] = [
      "status" : self.status as AnyObject,
      "id" : self.ID as AnyObject,
      "locationID" : self.locationID as AnyObject,
      "players" : self.playersToDictionary() as AnyObject,
      "startTime" : self.startTime as AnyObject,
      "firstToAsk" : self.firstToAsk as AnyObject
      
    ]
    
    return dict
    
  }
  
  func fromDictionary(dict: [String: AnyObject]) {
    self.status = dict["status"] as! Int
    self.ID = dict["id"] as! String
    self.locationID = dict["locationID"] as! String
    
    // Take the players array and convert it to a dictionary
    // let playersDict: [String: AnyObject] = arrayToDict(array: dict["players"] as! [AnyObject])
    self.players = playersFromData(data: dict["players"] as! [AnyObject])
    
    self.startTime = dict["startTime"] as! Int
    self.firstToAsk = dict["firstToAsk"] as! String
    
  }
  
  func playersFromData(data: [AnyObject]) -> [Player] {
    var players = [Player]()
    
    for playerItem in data {
      if let realPlayer = playerItem as? [String: AnyObject] {
        let player = Player(name: "")
        player.fromData(data: realPlayer)
        players.append(player)
        
      }
    }
    
    return players
  }
  
  func playersFromData(data: [String: AnyObject]) -> [Player] {
    var players = [Player]()
    
    var i = 0
    while i < data.count {
      let player = Player(name: "")
      
      if let dictVal = data["\(i)"] {
        player.fromData(data: dictVal as! [String : AnyObject])
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
      dict["\(i)"] = players[i].toDictionary() as AnyObject
      i += 1
    }
    
    return dict
    
  }
  
}

